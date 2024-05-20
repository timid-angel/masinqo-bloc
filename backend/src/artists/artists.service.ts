import { BadRequestException, Injectable, InternalServerErrorException, NotFoundException, UnauthorizedException } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Request } from 'express';
import mongoose from 'mongoose';
import { Admin } from 'src/auth/schema/admin.schema';
import { Artist } from 'src/auth/schema/artist.schema';
import * as jwt from 'jsonwebtoken'
import * as bcrypt from 'bcrypt'
import { Album } from 'src/albums/schemas/album.schema';
import { ObjectId } from 'mongodb';
import { existsSync, unlinkSync } from 'fs';

@Injectable()
export class ArtistsService {
    constructor(
        @InjectModel(Artist.name)
        private artistModel: mongoose.Model<Artist>,
        @InjectModel(Admin.name)
        private adminModel: mongoose.Model<Admin>,
        @InjectModel(Album.name)
        private albumModel: mongoose.Model<Album>
    ) { }

    async parseToken(req: Request, model: any, checkedRole: Number) {
        try {
            if (!req.cookies?.accessToken) {
                throw new BadRequestException('Cookie not found')
            }
            const token = req.cookies.accessToken
            const decoded = await jwt.verify(token, process.env.JWT_ACCESS_KEY)
            const idStr = (decoded as any).id
            const role = Number((decoded as any).role)
            const user = await model.findById(idStr)
            if (role !== checkedRole) throw new UnauthorizedException('Permission denied, not logged in as an authorized user')
            if (!user) {
                throw new UnauthorizedException('User not found.')
            }
            return user
        } catch (err) {
            throw new InternalServerErrorException(err.message)
        }
    }

    async getArtists(req: Request) {
        await this.parseToken(req, this.adminModel, 0)
        return this.artistModel.find({}).select("-password -__v")
    }

    async updateArtistAdmin(id: string, req: Request) {
        await this.parseToken(req, this.adminModel, 0)
        if (!ObjectId.isValid(id)) {
            throw new BadRequestException('Invalid ID provided in the route')
        }
        if (req.body.password) {
            req.body.password = await bcrypt.hash(req.body.password, 10)
        }
        await this.artistModel.findByIdAndUpdate(id, req.body)
        return this.artistModel.findById(id)
    }

    async updateArtist(req: Request, file: Express.Multer.File) {
        const artist = await this.parseToken(req, this.artistModel, 1)
        const reqBody = req.body

        if (file) {
            if (artist.profilePicture.length > 0) {
                const filePath = artist.profilePicture
                if (!existsSync(filePath)) {
                    throw new NotFoundException('File not found');
                }
                try {
                    unlinkSync(filePath);
                } catch (error) {
                    console.error('Error deleting song:', error);
                }
            }
            artist.profilePicture = file.path
        }

        if ("email" in reqBody && reqBody["email"].length > 0) {
            artist["email"] = reqBody["email"]
        }

        if ("name" in reqBody && reqBody["name"].length > 0) {
            artist["name"] = reqBody["name"]
        }

        if ("password" in reqBody && reqBody["password"].length > 0) {
            const newPassword = await bcrypt.hash(reqBody.password, 10);
            artist["password"] = newPassword
        }

        artist.save()
    }

    async deleteArtist(id: string, req: Request) {
        if (!ObjectId.isValid(id)) {
            throw new BadRequestException('Invalid ID provided in the route')
        }
        await this.parseToken(req, this.adminModel, 0)
        const artist = await this.artistModel.findById(id)
        if (!artist) {
            throw new BadRequestException('Artist with the provided ID does not exist.')
        }
        await this.albumModel.deleteMany({ artist: artist._id.valueOf() })
        await this.artistModel.findByIdAndDelete(id, req.body)
    }

    async changeBan(id: string, req: Request, newVal: boolean) {
        if (!ObjectId.isValid(id)) {
            throw new BadRequestException('Invalid ID provided in the route')
        }
        await this.parseToken(req, this.adminModel, 0)
        const artist = await this.artistModel.findById(id)
        if (!artist) {
            throw new BadRequestException('Artist with the provided ID does not exist.')
        }

        artist.banned = newVal
        artist.save()
    }
}
