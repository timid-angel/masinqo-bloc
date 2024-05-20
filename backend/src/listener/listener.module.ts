import { Module } from '@nestjs/common';
import { ListenerService } from './listener.service';
import { ListenerController } from './listener.controller';
import { AuthModule } from 'src/auth/auth.module';
import { MongooseModule } from '@nestjs/mongoose';
import { AdminSchema } from 'src/auth/schema/admin.schema';
import { ListenerSchema } from 'src/auth/schema/listener.schema';
import { AlbumSchema } from 'src/albums/schemas/album.schema';
import { PlaylistSchema } from 'src/playlist/schema/playlist.schema';

@Module({
  imports: [
    AuthModule,
    MongooseModule.forFeature([{ name: 'Admin', schema: AdminSchema }]),
    MongooseModule.forFeature([{ name: 'Listener', schema: ListenerSchema }]),
    MongooseModule.forFeature([{ name: 'Album', schema: AlbumSchema }]),
    MongooseModule.forFeature([{ name: 'Playlist', schema: PlaylistSchema }])
  ],
  controllers: [ListenerController],
  providers: [ListenerService],
})
export class ListenerModule { }
