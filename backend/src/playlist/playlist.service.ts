import { BadRequestException, Injectable, InternalServerErrorException, UnauthorizedException } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import mongoose from 'mongoose';
import { Listener } from 'src/auth/schema/listener.schema';
import { Playlist } from './schema/playlist.schema';
import * as jwt from 'jsonwebtoken'
import { ObjectId } from 'mongodb'
import { Request } from 'express';

@Injectable()
export class PlaylistService {
  constructor(
    @InjectModel(Listener.name)
    private listenerModel: mongoose.Model<Listener>,
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

  async create(req: Request) {
    const listener = await this.parseToken(req, this.listenerModel, 2)
    const { name } = req.body
    const playlist = await this.playlistModel.create({ name, owner: listener._id })
    listener.playlists.push(playlist._id.toString())
    listener.save()
    return playlist
  }

  async findAll(req: Request) {
    const listener = await this.parseToken(req, this.listenerModel, 2)
    return await this.playlistModel.find({ _id: { $in: listener.playlists } })
  }

  async findOne(req: Request, id: string) {
    const listener = await this.parseToken(req, this.listenerModel, 2)
    if (listener.playlists.indexOf(id) === -1) {
      throw new UnauthorizedException("The current listener is not the owner of the playlist or the playlist doesn't exist.")
    }

    return await this.playlistModel.find({ _id: id })
  }

  async update(req: Request, id: string) {
    const listener = await this.parseToken(req, this.listenerModel, 2)
    if (listener.playlists.indexOf(id) === -1) {
      throw new UnauthorizedException("The current listener is not the owner of the playlist or the playlist doesn't exist.")
    }
    const { name } = req.body
    const playlist = await this.playlistModel.findById(id)
    playlist.name = name
    playlist.save()
  }

  async remove(req: Request, id: string) {
    const listener = await this.parseToken(req, this.listenerModel, 2)
    if (listener.playlists.indexOf(id) === -1) {
      throw new UnauthorizedException("The current listener is not the owner of the playlist or the playlist doesn't exist.")
    }
    listener.playlists.remove(id)
    listener.save()
    return await this.playlistModel.findByIdAndDelete(id)
  }

  async addSong(req: Request, id: string) {
    const listener = await this.parseToken(req, this.listenerModel, 2)
    if (listener.playlists.indexOf(id) === -1) {
      throw new UnauthorizedException("The current listener is not the owner of the playlist or the playlist doesn't exist.")
    }
    const playlist = await this.playlistModel.findById(id)
    const { album, index } = req.body
    const song = { album, index }
    playlist.songs.push(song)
    playlist.save()
  }

  async removeSong(req: Request, id: string) {
    const listener = await this.parseToken(req, this.listenerModel, 2)
    if (listener.playlists.indexOf(id) === -1) {
      throw new UnauthorizedException("The current listener is not the owner of the playlist or the playlist doesn't exist.")
    }
    const playlist = await this.playlistModel.findById(id)
    const { album, index } = req.body
    playlist.songs = playlist.songs.filter((song) => (song.album != album && song.index != index))
    playlist.save()
  }
}
