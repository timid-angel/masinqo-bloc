import { Module } from '@nestjs/common';
import { AuthService } from './auth.service';
import { AuthController } from './auth.controller';
import { MongooseModule } from '@nestjs/mongoose';
import { ArtistSchema } from './schema/artist.schema';
import { JwtModule } from '@nestjs/jwt';
import { ConfigService } from '@nestjs/config';
import { AdminSchema } from './schema/admin.schema';
import { ListenerSchema } from './schema/listener.schema';

@Module({
  imports: [
    JwtModule.registerAsync({
      inject: [ConfigService],
      useFactory: (config: ConfigService) => {
        return {
          secret: config.get<string>('JWT_ACCESS_KEY'),
          signOptions: { expiresIn: config.get<string | number>('JWT_EXPIRATION') }
        }
      }
    }),
    MongooseModule.forFeature([{ name: 'Artist', schema: ArtistSchema }, { name: 'Admin', schema: AdminSchema }, { name: 'Listener', schema: ListenerSchema }])
  ],
  controllers: [AuthController],
  providers: [AuthService]
})
export class AuthModule { }
