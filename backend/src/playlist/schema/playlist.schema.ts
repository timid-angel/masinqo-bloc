import { Prop, Schema, SchemaFactory } from "@nestjs/mongoose";
import { Document } from "mongoose";

class Song {
    album: string
    index: number
}

@Schema()
export class Playlist extends Document {
    @Prop()
    name: string

    @Prop()
    owner: string

    @Prop({ default: [] })
    songs: Array<Song>
}

export const PlaylistSchema = SchemaFactory.createForClass(Playlist)