import { Prop, Schema, SchemaFactory } from "@nestjs/mongoose";
import { Document } from "mongoose";

@Schema()

export class Admin extends Document {
    @Prop({ unique: [true, 'Email already exists'] })
    email: string

    @Prop()
    password: string
}

export const AdminSchema = SchemaFactory.createForClass(Admin)