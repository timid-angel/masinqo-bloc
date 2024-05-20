import { Controller, Delete, Get, Param, Put, Req, Patch, UseInterceptors, UploadedFile } from '@nestjs/common';
import { ArtistsService } from './artists.service';
import { Request } from 'express';
import { FileInterceptor } from '@nestjs/platform-express';
import { diskStorage } from 'multer';
import { extname } from 'path';

@Controller('artists')
export class ArtistsController {
    constructor(
        private artistService: ArtistsService
    ) { }

    @Get()
    async getArtists(@Req() req: Request) {
        return this.artistService.getArtists(req)
    }

    @Patch('update')
    @UseInterceptors(FileInterceptor('profilePicture', {
        storage: diskStorage({
            destination: './local/artist-pictures',
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
    async updateArtist(@Req() req: Request, @UploadedFile() file: Express.Multer.File) {
        return this.artistService.updateArtist(req, file)
    }

    @Put(':id')
    async updateArtistAdmin(@Param('id') id: string, @Req() req: Request) {
        return this.artistService.updateArtistAdmin(id, req)
    }

    @Delete(':id')
    async deleteArtist(@Param('id') id: string, @Req() req: Request) {
        return this.artistService.deleteArtist(id, req)
    }

    @Patch('/ban/:id')
    async banArtist(@Param('id') id: string, @Req() req: Request) {
        return this.artistService.changeBan(id, req, true)
    }

    @Patch('/unban/:id')
    async unBanArtist(@Param('id') id: string, @Req() req: Request) {
        return this.artistService.changeBan(id, req, false)
    }
}
