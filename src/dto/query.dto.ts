import { ApiProperty } from '@nestjs/swagger';
export class PageQueryDto {
  @ApiProperty({ required: false })
  page?: number
  @ApiProperty({ required: false })
  size?: number
  @ApiProperty({ required: false })
  order?: string
  @ApiProperty({ required: false })
  sort_by?: string
}

export class FileQueryDto extends PageQueryDto {
  @ApiProperty({ required: false })
  tag?: string
  @ApiProperty({ required: false })
  reference_id?: string
  @ApiProperty({ required: false })
  created_by?: string
}

export class GameQueryDto extends PageQueryDto {
  @ApiProperty({ required: false })
  court_type?: string
  @ApiProperty({ required: false })
  game_type?: string
  @ApiProperty({ required: false })
  city_code?: string
  @ApiProperty({ required: false })
  dist_code?: string
  @ApiProperty({ required: false, type: Date })
  start?: Date
  @ApiProperty({ required: false, type: Date })
  end?: Date
  @ApiProperty({ required: false })
  game_name?: string
}