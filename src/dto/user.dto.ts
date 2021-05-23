import { IsEmail, IsNotEmpty, IsUUID, IsString, IsOptional } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';

export class UserDto {

	@IsUUID()
	@IsOptional()
	user_id: string;

	@IsString()
	@IsNotEmpty()
	@ApiProperty()
	profile_name: string;

	@IsEmail()
	@ApiProperty()
	email: string;

	@IsString()
	@IsOptional()
	@ApiProperty()
	gender: string;

	@IsString()
	@IsNotEmpty()
	@ApiProperty()
	phone: string;

	@IsNotEmpty()
	@IsString()
	@ApiProperty()
	password: string;

	@IsString()
	@IsOptional()
	@ApiProperty()
	description: string;

	@IsOptional()
	@ApiProperty()
	meta: object;

}

export class PasswordDto {
	@IsString()
	@IsNotEmpty()
	@ApiProperty()
	password: string;

	@IsString()
	@IsNotEmpty()
	@ApiProperty()
	new_password: string;
}
