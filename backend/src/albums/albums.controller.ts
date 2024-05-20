import { Body, Controller, Delete, Get, HttpStatus, NotFoundException, Param, Patch, Post, Put, Query, Redirect, Render, Req, Res, UploadedFile, UseGuards, UseInterceptors } from '@nestjs/common';
import { AlbumsService } from './albums.service';
import { Album } from './schemas/album.schema';
import { Request, Response } from 'express'
import { Query as EQuery } from 'express-serve-static-core'
import { FileInterceptor } from '@nestjs/platform-express';
import { diskStorage } from 'multer';
import { extname } from 'path/posix';
import { ArtistsService } from 'src/artists/artists.service';

@Controller('albums')
export class AlbumsController {
    constructor(
        private albumService: AlbumsService
    ) { }

    @Get()
    async getAllAlbums(@Req() req: Request, @Query() query: EQuery): Promise<Album[]> {
        return this.albumService.findAll(req, query)
    }


    @Get('/published')
    async getAlbumByArtistId(@Req() req: Request) {
        return this.albumService.findByArtistId(req)
    }

    @Get(':id')
    async findAlbumById(@Param('id') id: string): Promise<Album> {
        return this.albumService.findById(id)
    }

    @Get('/images/:id')
    async getAlbumArt(@Param('id') id: string, @Res() res: Response): Promise<void> {
        try {
            const result = await this.albumService.getAlbumArtPath(id); // Update to use albumService
            if (!result) {
                res.status(404).send('Album not found');
                return;
            }

            // Send the image file
            res.sendFile(result);
        } catch (error) {
            res.status(500).send('Internal Server Error');
        }
    }


    @Post()
    @UseInterceptors(FileInterceptor('albumArt', {
        storage: diskStorage({
            destination: './local/album-thumbnails',
            filename: (req, file, callback) => {
                callback(null, Date.now() + `${file.originalname}`)
            }
        }),
        fileFilter: (req, file, callback) => {
            const imageExtensions = ['.png', '.jpg', '.jpeg'];
            const fileExtension = extname(file.originalname);
            if (imageExtensions.includes(fileExtension)) {
                callback(null, true);
            } else {
                console.log('Invalid file format. Only png, jpg and jpeg formats are accepted')
                callback(null, false);
                return
            }
        },
    }))
    async createAlbum(@Req() req: Request, @UploadedFile() file: Express.Multer.File): Promise<Album> {
        return this.albumService.createAlbum(req, file)
    }

    @Put(':id')
    async updateAlbum(@Param('id') id: string, @Req() req: Request) {
        console.log(req.body)
        return await this.albumService.updateById(id, req)
    }

    @Delete(':id')
    async deleteAblum(@Param('id') id: string, @Req() req: Request) {
        return await this.albumService.deleteById(id, req)
    }

    // routes for songs
    @Get('songs/:id')
    async findAlbumSongs(@Param('id') id: string) {
        return this.albumService.findAlbumSongs(id)
    }

    @Post('songs/:id')
    @UseInterceptors(FileInterceptor('song', {
        storage: diskStorage({
            destination: './local/audio',
            filename: (req, file, callback) => {
                callback(null, Date.now() + `${file.originalname}`)
            }
        }),
        fileFilter: (req, file, callback) => {
            const imageExtensions = ['.mp3', '.wav'];
            const fileExtension = extname(file.originalname);
            if (imageExtensions.includes(fileExtension)) {
                callback(null, true);
            } else {
                console.log('invalid file format only mp3 and wav formats are valid')
                callback(null, false);
                return
            }
        },
    }))
    async addSong(@Param('id') id: string, @Req() req: Request, @UploadedFile() file: Express.Multer.File) {
        return await this.albumService.addSong(id, req, file)
    }

    @Delete('songs/:id')
    async removeSong(@Param('id') id: string, @Req() req: Request) {
        return await this.albumService.removeSong(id, req)
    }

    // used to get songs for playlists
    @Get('/songs/:id/:idx')
    async getSong(@Param('id') id: string, @Param('idx') idx: string) {
        return this.albumService.getSong(id, idx)
    }
}