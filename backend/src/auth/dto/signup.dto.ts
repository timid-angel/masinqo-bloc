import { IsEmail, IsEnum, IsNotEmpty, IsString, MinLength } from "class-validator"

export class SignUpDto {
    @IsNotEmpty()
    @IsString()
    readonly name: string

    @IsNotEmpty()
    @IsEmail({}, { message: "Please enter a valid email" })
    readonly email: string

    @IsNotEmpty()
    @IsString()
    @MinLength(4)
    readonly password: string
}