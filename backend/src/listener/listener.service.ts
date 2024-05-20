import { BadRequestException, Injectable, InternalServerErrorException, UnauthorizedException } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import mongoose from 'mongoose';
import { Admin } from 'src/auth/schema/admin.schema';
import { Listener } from 'src/auth/schema/listener.schema';
import * as jwt from 'jsonwebtoken'
import * as bcrypt from 'bcrypt'
import { ObjectId } from 'mongodb';
import { Request } from 'express';
import { Album } from 'src/albums/schemas/album.schema';
import { Playlist } from 'src/playlist/schema/playlist.schema';

@Injectable()
export class ListenerService {
  constructor(
    @InjectModel(Listener.name)
    private listenerModel: mongoose.Model<Listener>,
    @InjectModel(Admin.name)
    private adminModel: mongoose.Model<Admin>,
    @InjectModel(Album.name)
    private albumModel: mongoose.Model<Album>,
    @InjectModel(Playlist.name)
    private playlistModel: mongoose.Model<Playlist>,
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

  async getAlbumById(id: string) {
    if (!ObjectId.isValid(id)) {
      throw new BadRequestException('Invalid ID provided in the route')
    }

    return await this.albumModel.findById(id)
  }

  async findAll(req: Request) {
    await this.parseToken(req, this.adminModel, 0)
    return this.listenerModel.find({}).select("-password -__v")
  }

  async update(req: Request) {
    const artist = await this.parseToken(req, this.listenerModel, 2)
    const reqBody = req.body

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

  async remove(req: Request, id: string) {
    if (!ObjectId.isValid(id)) {
      throw new BadRequestException('Invalid ID provided in the route')
    }
    await this.parseToken(req, this.adminModel, 0)
    const listener = this.listenerModel.findById(id)
    if (!listener) {
      throw new BadRequestException('Listener with the provided ID does not exist.')
    }

    await this.playlistModel.deleteMany({ owner: id })
    await this.listenerModel.findByIdAndDelete(id)
  }

  async getFavorites(req: Request) {
    const listener = await this.parseToken(req, this.listenerModel, 2)
    if (!listener) {
      throw new BadRequestException('Listener with the provided ID does not exist.')
    }

    return this.albumModel.find({ _id: { $in: listener.favorites } })
  }

  async addFavorite(req: Request, id: string) {
    const listener = await this.parseToken(req, this.listenerModel, 2)
    if (!listener) {
      throw new BadRequestException('Listener with the provided ID does not exist.')
    }

    const album = await this.getAlbumById(id)
    if (!album) {
      throw new BadRequestException('Album with the provided ID does not exist.')
    }

    listener.favorites.push(id.toString())
    listener.save()
    return listener.favorites[listener.favorites.length - 1]
  }

  async removeFavorite(req: Request, id: string) {
    const listener = await this.parseToken(req, this.listenerModel, 2)
    if (!listener) {
      throw new BadRequestException('Listener with the provided ID does not exist.')
    }

    const album = await this.getAlbumById(id)
    if (!album) {
      throw new BadRequestException('Album with the provided ID does not exist.')
    }

    listener.favorites.remove(id)
    listener.save()
  }
}
