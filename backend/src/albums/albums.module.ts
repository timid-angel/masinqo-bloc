import { Module } from '@nestjs/common';
import { AlbumsController } from './albums.controller';
import { AlbumsService } from './albums.service';
import { MongooseModule } from '@nestjs/mongoose';
import { AlbumSchema } from './schemas/album.schema';
import { AuthModule } from 'src/auth/auth.module';
import { ArtistSchema } from 'src/auth/schema/artist.schema';

@Module({
  imports: [
    AuthModule,
    MongooseModule.forFeature([{ name: 'Album', schema: AlbumSchema }]),
    MongooseModule.forFeature([{ name: 'Artist', schema: ArtistSchema }])
  ],
  controllers: [AlbumsController],
  providers: [AlbumsService]
})
export class AlbumsModule { }
