import { Module } from '@nestjs/common';
import { PlaylistService } from './playlist.service';
import { PlaylistController } from './playlist.controller';
import { MongooseModule } from '@nestjs/mongoose';
import { ListenerSchema } from 'src/auth/schema/listener.schema';
import { PlaylistSchema } from './schema/playlist.schema';

@Module({
  imports: [
    MongooseModule.forFeature([{ name: 'Listener', schema: ListenerSchema }]),
    MongooseModule.forFeature([{ name: 'Playlist', schema: PlaylistSchema }])
  ],
  controllers: [PlaylistController],
  providers: [PlaylistService],
})
export class PlaylistModule { }
