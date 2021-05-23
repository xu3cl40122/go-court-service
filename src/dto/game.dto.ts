import { IsEmail, IsNotEmpty, IsUUID, IsString, IsOptional, IsDateString, IsNumber, IsEnum, IsBoolean } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';
import {
	CourtType,
	GameType,
	GameStatus
} from '../entity/game.entity'
export class CreateGameDto {

	@IsUUID()
	@IsOptional()
	@ApiProperty()
	game_id: string;

	@IsString()
	@IsNotEmpty()
	@ApiProperty()
	game_name: string;

	host_user_id: string;

	@ApiProperty()
	court_id: string;

	@IsDateString()
	@ApiProperty()
	game_start_at: Date;

	@IsDateString()
	@ApiProperty()
	game_end_at: Date;

	@IsDateString()
	@ApiProperty()
	sell_start_at: Date;

	@IsDateString()
	@ApiProperty()
	sell_end_at: Date;

	@IsOptional()
	@IsNumber()
	@ApiProperty()
	total_player_number: number;

	@IsEnum(CourtType)
	@ApiProperty({ enum: CourtType })
	court_type: string;

	@IsEnum(GameType)
	@ApiProperty({ enum: GameType })
	game_type: string;

	@IsString()
	@ApiProperty()
	description: string;

	@IsOptional()
	@IsEnum(GameStatus)
	@ApiProperty({ enum: GameStatus })
	game_status: string;

	@IsOptional()
	@ApiProperty()
	meta: object;

	@IsBoolean()
	@ApiProperty()
	is_public: boolean;

	@IsOptional()
	@IsBoolean()
	@ApiProperty()
	deleted: boolean;

}
