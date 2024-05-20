import { IsEmpty, IsEnum, IsNotEmpty, IsString } from "class-validator"
import { Artist } from "src/auth/schema/artist.schema"

export class CreateAlbumDto {
    @IsNotEmpty()
    @IsString()
    readonly title: string

    @IsNotEmpty()
    readonly type: "Album" | "Single"

    @IsNotEmpty()
    readonly genre: string
    readonly description: string
    readonly image: string

    @IsEmpty({ message: "User ID can't be manually passed." })
    readonly artist: string
}