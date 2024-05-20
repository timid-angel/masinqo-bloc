import { Module } from '@nestjs/common';
import { ArtistsController } from './artists.controller';
import { ArtistsService } from './artists.service';
import { AuthModule } from 'src/auth/auth.module';
import { MongooseModule } from '@nestjs/mongoose';
import { AdminSchema } from 'src/auth/schema/admin.schema';
import { ArtistSchema } from 'src/auth/schema/artist.schema';
import { AlbumSchema } from 'src/albums/schemas/album.schema';

@Module({
  imports: [
    AuthModule,
    MongooseModule.forFeature([{ name: 'Admin', schema: AdminSchema }]),
    MongooseModule.forFeature([{ name: 'Artist', schema: ArtistSchema }]),
    MongooseModule.forFeature([{ name: 'Album', schema: AlbumSchema }])
  ],
  controllers: [ArtistsController],
  providers: [ArtistsService]
})
export class ArtistsModule { }
