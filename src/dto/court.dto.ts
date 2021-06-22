import { ApiProperty } from '@nestjs/swagger';
import { IsString, IsNotEmpty, IsOptional, IsBoolean, IsNumber, IsEnum } from 'class-validator';
import { CourtOpenStatus } from '../entity/court.entity';
export class CourtDto {
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

  @IsNotEmpty()
  @ApiProperty()
  latitude: number;

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

  @IsEnum(CourtOpenStatus)
  @ApiProperty()
  open_status: string;

  geometry: object;

  @IsOptional()
  @ApiProperty()
  meta: object;
}


