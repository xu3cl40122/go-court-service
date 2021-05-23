import { IsEmail, IsNotEmpty, IsUUID, IsString, IsOptional, IsDate, IsNumber, IsEnum, IsBoolean } from 'class-validator';
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

	@IsUUID()
	@ApiProperty()
	host_user_id: string;

	@IsUUID()
	@ApiProperty()
	court_id: string;

	@IsDate()
	@ApiProperty()
	game_start_at: Date;

	@IsDate()
	@ApiProperty()
	game_end_at: Date;

	@IsDate()
	@ApiProperty()
	sell_start_at: Date;

	@IsDate()
	@ApiProperty()
	sell_end_at: Date;

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
