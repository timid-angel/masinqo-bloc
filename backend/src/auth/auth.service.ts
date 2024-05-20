import { Injectable, UnauthorizedException } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Artist } from './schema/artist.schema';
import * as bcrypt from 'bcrypt'
import { Model } from 'mongoose';
import { JwtService } from '@nestjs/jwt';
import { SignUpDto } from './dto/signup.dto';
import { LogInDto } from './dto/login.dto';
import { Admin } from './schema/admin.schema';
import { AdminSignUpDto } from './dto/signup-admin.dto';
import { Listener } from './schema/listener.schema';

@Injectable()
export class AuthService {
  constructor(
    @InjectModel(Artist.name)
    private artistModel: Model<Artist>,
    @InjectModel(Admin.name)
    private adminModel: Model<Admin>,
    @InjectModel(Listener.name)
    private listenerModel: Model<Listener>,
    private jwtService: JwtService,
  ) { }

  // artist
  async artistSignUp(reqBody: SignUpDto): Promise<{ token: string }> {
    const artistObj = { ...reqBody };
    const hashedPwd = await bcrypt.hash(reqBody.password, 10);
    artistObj.password = hashedPwd;
    const artist = await this.artistModel.create(artistObj);
    const accessToken = this.jwtService.sign({ id: artist._id, role: 1 });
    return { token: accessToken };
  }

  async artistLogIn(reqBody: LogInDto): Promise<{ token: string }> {
    const accObj = { ...reqBody };
    const artist = await this.artistModel.findOne({ email: accObj.email });
    if (!artist) {
      throw new UnauthorizedException('Invalid email or password');
    }
    if (artist?.banned) {
      throw new UnauthorizedException('Account has been banned')
    }
    const valid = await bcrypt.compare(accObj.password, artist.password);
    let accessToken: string;
    if (valid) {
      accessToken = this.jwtService.sign({ id: artist._id, role: 1 });
    }
    return { token: accessToken };
  }

  // listener
  async listenerSignUp(reqBody: SignUpDto): Promise<{ token: string }> {
    const listenerObj = { ...reqBody };
    const hashedPwd = await bcrypt.hash(reqBody.password, 10);
    listenerObj.password = hashedPwd;
    const listener = await this.listenerModel.create(listenerObj);
    const accessToken = this.jwtService.sign({ id: listener._id, role: 2 });
    return { token: accessToken };
  }

  async listenerLogIn(reqBody: LogInDto): Promise<{ token: string }> {
    const accObj = { ...reqBody };
    const listener = await this.listenerModel.findOne({ email: accObj.email });
    if (!listener) {
      throw new UnauthorizedException('Invalid email or password');
    }
    const valid = await bcrypt.compare(accObj.password, listener.password);
    let accessToken: string;
    if (valid) {
      accessToken = this.jwtService.sign({ id: listener._id, role: 2 });
    }
    return { token: accessToken };
  }

  // admin
  async adminSignUp(reqBody: AdminSignUpDto): Promise<{ token: string }> {
    const adminObj = { ...reqBody };
    const hashedPwd = await bcrypt.hash(reqBody.password, 10);
    adminObj.password = hashedPwd;
    const admin = await this.adminModel.create(adminObj);
    const accessToken = this.jwtService.sign({ id: admin._id, role: 0 });
    return { token: accessToken };
  }

  async adminLogIn(reqBody: LogInDto): Promise<{ token: string }> {
    const accObj = { ...reqBody };
    const admin = await this.adminModel.findOne({ email: accObj.email });
    if (!admin) {
      throw new UnauthorizedException('Invalid email or password');
    }
    const valid = await bcrypt.compare(accObj.password, admin.password);
    let accessToken: string;
    if (valid) {
      accessToken = this.jwtService.sign({ id: admin._id, role: 0 });
    }
    return { token: accessToken };
  }
}
