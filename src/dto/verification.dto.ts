import { IsEmail, IsNotEmpty } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';

export class SendEmailDto {
	@IsEmail()
	@ApiProperty()
	email: string;
}

export class VerificationDto {
	@IsEmail()
	@ApiProperty()
	email: string;

	@IsNotEmpty()
	@ApiProperty()
	verification_code: string;
}
