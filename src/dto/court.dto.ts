import { ApiProperty } from '@nestjs/swagger';
import { IsUUID, IsString, IsNotEmpty, IsOptional, IsBoolean, IsNumber, IsEnum } from 'class-validator';
import { CourtType } from '../entity/game.entity';
export class CourtDto {
  @IsUUID()
  @IsOptional()
  @ApiProperty()
  court_id: number;

  @IsString()
  @IsNotEmpty()
  @ApiProperty()
  name: string;

  @IsString()
  @IsNotEmpty()
  @ApiProperty()
  address: string;

  @IsString()
  @IsNotEmpty()
  @ApiProperty()
  city_code: string;

  @IsString()
  @IsNotEmpty()
  @ApiProperty()
  dist_code: string;

  @IsNumber()
  @IsNotEmpty()
  @ApiProperty()
  latitude: number;

  @IsNumber()
  @IsNotEmpty()
  @ApiProperty()
  longitude: number;

  @IsString()
  @IsNotEmpty()
  @ApiProperty()
  phone: string;

  @IsString()
  @IsOptional()
  @ApiProperty()
  logo_url: string;

  @IsString()
  @IsOptional()
  @ApiProperty()
  description: string;

  @IsEnum(CourtType)
  @ApiProperty()
  open_status: string;

  geometry: object;

  @IsOptional()
  @ApiProperty()
  meta: object;
}


