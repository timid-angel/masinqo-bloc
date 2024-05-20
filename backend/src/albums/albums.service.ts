import { BadRequestException, Injectable, InternalServerErrorException, NotFoundException, UnauthorizedException } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Album } from './schemas/album.schema';
import * as mongoose from 'mongoose';
import { Artist } from 'src/auth/schema/artist.schema';
import * as jwt from 'jsonwebtoken'
import { ObjectId } from 'mongoose';
import { Request } from 'express'
import { Song } from './schemas/song';
import { existsSync, unlinkSync } from 'fs';
import { extname, join } from 'path';
import { Query as EQuery } from 'express-serve-static-core';

@Injectable()
export class AlbumsService {
    constructor(
        @InjectModel(Album.name)
        private albumModel: mongoose.Model<Album>,
        @InjectModel(Artist.name)
        private artistModel: mongoose.Model<Artist>
    ) { }

    // reads access token from the request object
    // decodes the payload in the token and returns the artist identified by the id field of the payload
    async parseToken(req: Request) {
        try {
            if (!req.cookies?.accessToken) {
                throw new BadRequestException('Cookie not found')
            }
            const token = req.cookies.accessToken
            const decoded = await jwt.verify(token, process.env.JWT_ACCESS_KEY)
            const idStr = (decoded as any).id
            const role = Number((decoded as any).role)
            const artist = await this.artistModel.findById(idStr)
            if (role !== 1) throw new UnauthorizedException('Logged in as an Admin, not as an Artist')
            if (!artist) {
                throw new UnauthorizedException('User not found.')
            }
            return artist
        } catch (err) {
            throw new InternalServerErrorException(err.message)
        }
    }

    // GET to /albums
    async findAll(req: Request, query: EQuery): Promise<Album[]> {
        const artist: any = await this.parseToken(req)
        if (!artist) {
            throw new BadRequestException('Cookie not found')
        }
        const albumsPerPage = 6
        const currentPage = Number(query.page) || 1
        const skipCount = albumsPerPage * (currentPage - 1)
        const albums = await this.albumModel
            .find({ artist: artist._id.valueOf() })
            .limit(albumsPerPage).skip(skipCount)
        return albums
    }

    async getArtistInfo(req) {
        const artist: any = await this.parseToken(req)
        if (!artist) {
            throw new BadRequestException('Cookie not found')
        }
        return { artistName: artist.name }
    }

    // GET to /albums/:id
    async findById(id: string): Promise<Album> {
        if (!mongoose.isValidObjectId(id)) {
            throw new BadRequestException('Please enter a valid ID')
        }
        const album = await this.albumModel.findById(id)
        if (!album) {
            throw new NotFoundException('Album not found')
        }
        return album
    }

    async findByArtistId(req: Request) {
        const artist: any = await this.parseToken(req)
        if (!artist) {
            throw new BadRequestException('Cookie not found')
        }
        console.log(artist)
        const album = await this.albumModel.find({ artist: artist._id.toString() })
        return album
    }

    async getAlbumInfo(id: string) {
        const album = await this.albumModel.findById(id)
        if (!album) {
            throw new BadRequestException('Album not found')
        }
        const artist = await this.artistModel.findById(album.artist)
        if (!artist) {
            throw new BadRequestException('Album not found')
        }
        const date = new Date(album.date)
        // album art file path
        let path = '/images/albumPlaceholder.png'
        if (album.albumArtPath) {
            const arr = album.albumArtPath.split('\\')
            path = "/" + arr[1] + "/" + arr[2]
        }

        return {
            artistName: artist.name,
            albumDate: date.toLocaleString('default', { month: "long" }) + " " + date.getUTCDate() + ", " + date.getUTCFullYear(),
            trackNumber: album.songs.length,
            genre: album.genre,
            description: album.description,
            albumArt: path,
            albumTitle: album.title
        }
    }

    // POST to /albums
    async createAlbum(req: Request, file: Express.Multer.File): Promise<Album> {
        const album = req.body
        if (!album) {
            throw new BadRequestException('Empty data set')
        }
        const artist: any = await this.parseToken(req)
        const data = { ...album, artist: artist.id.valueOf(), date: new Date() }
        const newAlbum = await this.albumModel.create(data)
        const id: string = newAlbum._id.toString()
        return this.uploadAlbumImage(id, file)
    }

    // helper function for createAlbum - uploads the image to the FS and stores the path in the album object
    async uploadAlbumImage(id: string, file: Express.Multer.File) {
        if (!file) {
            throw new BadRequestException('File not selected. Select a file to upload');
        }
        const imageExtensions = ['.png', '.jpg', '.jpeg']
        const fileExtension = extname(file.originalname)
        if (!imageExtensions.includes(fileExtension)) {
            throw new BadRequestException('Invalid file format. Only png, jpg, and jpeg formats are valid');
        }
        const albumArtPath = file.path;
        try {
            const album = await this.albumModel.findById(id);
            if (!album) {
                throw new NotFoundException('Album not found');
            }
            album.albumArtPath = albumArtPath;
            await album.save();
            return album;
        } catch (error) {
            throw new InternalServerErrorException(error.message);
        }
    }

    // PUT to /albums/:id
    async updateById(id: string, req: Request): Promise<Album> {
        const updates = req.body
        if (!updates) {
            throw new BadRequestException('Empty data set')
        }
        const artistFromToken: any = await this.parseToken(req)
        const album = await this.albumModel.findById(id)
        if (artistFromToken._id.valueOf() !== album.artist) {
            throw new UnauthorizedException('Only creators of an album can edit it.')
        }
        await this.albumModel.findByIdAndUpdate(id, updates)
        return this.albumModel.findById(id)
    }

    // DELETE to /albums/:id
    async deleteById(id: string, req: Request) {
        const artistFromToken: any = await this.parseToken(req)
        const artistFromAlbum = await this.albumModel.findById(id)
        if (!artistFromAlbum || !artistFromToken) {
            throw new BadRequestException("Album could not be found")
        }
        if (artistFromToken._id.valueOf() !== artistFromAlbum.artist) {
            throw new UnauthorizedException('Only creators of an album can edit it.')
        }

        await this.deleteAlbumSongs(id)
        await this.deleteAlbumArt(id, req)
        await this.albumModel.findByIdAndDelete(id)
    }

    // helper function for deleteById - deletes the song files from the FS
    async deleteAlbumSongs(id: string) {
        const album = await this.findById(id);
        if (!album) {
            throw new NotFoundException('Album not found');
        }

        for (let i = 0; i < album.songs.length; i++) {
            const filePath = album.songs[i].filePath
            if (!existsSync(filePath)) {
                throw new NotFoundException('File not found');
            }
            try {
                unlinkSync(filePath);
            } catch (error) {
                console.error('Error deleting song:', error);
            }
        }
    }

    // helper function for deleteById - deletes the image from the FS
    async deleteAlbumArt(id: string, req: Request) {
        const album = await this.findById(id);
        if (!album) {
            throw new NotFoundException('Album not found');
        }
        if (album.albumArtPath) {
            const filePath = "./" + album.albumArtPath
            if (!existsSync(album.albumArtPath)) {
                throw new NotFoundException('File not found');
            }
            try {
                unlinkSync(filePath);
            } catch (error) {
                console.error('Error deleting album art:', error);
            }
        }
    }

    // SONGS
    // POST to /albums/songs/:id
    async addSong(id: string, req: Request, file: Express.Multer.File) {
        const song: { name } = req.body
        if (!song) {
            throw new BadRequestException('Empty data set')
        }
        const artistFromToken: any = await this.parseToken(req)
        const album = await this.albumModel.findById(id)
        if (artistFromToken._id.valueOf() !== album.artist) {
            throw new UnauthorizedException('Only creators of an album can add songs')
        }
        const duplicateName = album.songs.find(item => item.name === song.name)
        if (duplicateName) {
            try {
                const filePath = join(__dirname, "..", "..", "local", "audio", file.filename)
                setTimeout(() => { unlinkSync(filePath) }, 1000);
                throw new BadRequestException('A song with a similar name already exists on this album')
            } catch (err) {
                console.log(err.message)
            }
            return
        }
        album.songs.push({
            name: song.name,
            filePath: ""
        })
        await album.save()
        return await this.uploadSong(id, file, album.songs.length - 1)
    }

    async findAlbumSongs(id: string) {
        if (!mongoose.isValidObjectId(id)) {
            throw new BadRequestException('Please enter a valid ID')
        }
        const album = await this.albumModel.findById(id)
        if (!album) {
            throw new NotFoundException('Album not found')
        }
        return album.songs
    }

    async getAlbumArtPath(id: string): Promise<string | undefined> {
        try {
            const album = await this.albumModel.findById(id);
            if (!album) {
                return undefined; // Album not found
            }

            const albumArtPath = album.albumArtPath;
            if (!albumArtPath) {
                return undefined; // Album art path not available
            }

            return albumArtPath;
        } catch (error) {
            throw new InternalServerErrorException(error.message);
        }
    }

    // helper function for addSong - uploads the audio to the FS and stores the path in the song object
    async uploadSong(id: string, file: Express.Multer.File, songIndex) {
        if (!file) {
            throw new BadRequestException('File not selected. select a file to upload');
        }
        const audioExtensions = ['.mp3', '.wav']
        const fileExtension = extname(file.originalname)
        if (!audioExtensions.includes(fileExtension)) {
            throw new BadRequestException('invalid file format only mp3 and wav formats are valid')
        }
        const songPath = file.path;
        const songName = file.originalname
        try {
            const document: any = await this.albumModel.findOne({ _id: id })
            if (!document) {
                throw new NotFoundException('Document not found');
            }
            if (songIndex !== -1) {
                document.songs[songIndex] = {
                    name: document.songs[songIndex].name,
                    filePath: songPath
                }
                await document.save();
                return document.songs;
            }
            else {
                throw new NotFoundException('File name not found');
            }
        } catch (error) {
            throw new InternalServerErrorException(error.message);
        }
    }

    // DELETE to /albums/songs/:id
    async removeSong(id: string, req: Request) {
        const song: { name: string } = req.body
        const songName = song.name
        if (!song) {
            throw new BadRequestException('Empty data set')
        }
        const artistFromToken: any = await this.parseToken(req)
        const album = await this.albumModel.findById(id)
        if (artistFromToken._id.valueOf() !== album.artist) {
            throw new UnauthorizedException('Only creators of an album can remove songs')
        }
        let found = false
        album.songs = album.songs.filter((item: Song) => {
            if (item.name === songName) {
                found = true
                return false
            }
            return true
        })
        if (!found) {
            throw new BadRequestException('Song does not exist in the Album')
        }
        await this.deleteSongFile(id, song.name)
        await album.save()
        return album.songs
    }

    // helper function for removeSong - deletes the audio from the FS and the entry from the database
    async deleteSongFile(id: string, songName: string) {
        const document = await this.albumModel.findOne({ _id: id })
        if (!document) {
            throw new Error('Document not found');
        }
        const songIndex = document.songs.findIndex(song => song.name == songName);
        if (songIndex !== -1) {
            const filePath = document.songs[songIndex].filePath
            if (!existsSync(filePath)) {
                throw new NotFoundException('File not found');
            }
            try {
                unlinkSync(filePath);
            } catch (error) {
                console.error('Error deleting song:', error);
            }
        } else {
            throw new NotFoundException('File not found');
        }
        await document.save();
        return document;
    }

    async getSong(albumId: string, idx: string) {
        if (isNaN(parseInt(idx))) throw new BadRequestException('Invalid song index - non numeric index')

        const album = await this.albumModel.findById(albumId)
        const songIdx = parseInt(idx)

        if (songIdx < album.songs.length) {
            return album.songs[songIdx]
        }

        throw new BadRequestException('Invalid song index - index out of bound')
    }
}