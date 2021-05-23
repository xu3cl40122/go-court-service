import {
  Controller,
  Get,
  Post,
  Put,
  Delete,
  Param,
  Body,
  Query,
  HttpException,
  HttpStatus,
  UseGuards,
  Req,
} from '@nestjs/common';
import { CourtService } from './courts.service';
import { JwtAuthGuard } from '../auth/jwt.guard';
import { CourtQueryDto } from '../../dto/query.dto'
import { CourtDto } from '../../dto/court.dto'
import { ApiOkResponse, ApiCreatedResponse, ApiHeader, ApiTags, ApiOperation, ApiBody } from '@nestjs/swagger';
import { getManyResponseFor } from '../../methods/spec'
import { Court } from '../../entity/court.entity'

@Controller('courts')
@ApiTags('courts')
export class CourtController {
  constructor(
    private readonly courtService: CourtService
  ) { }

  @Get()
  @ApiOperation({ summary: '搜尋球場' })
  @ApiOkResponse({ type: getManyResponseFor(Court) })
  async queryCourts(@Query() query: CourtQueryDto): Promise<Object> {
    return this.courtService.queryCourts(query);
  }

  @Get('/:court_id')
  @ApiOperation({ summary: '取得球場詳細資訊' })
  @ApiOkResponse({ type: Court })
  async getGameById(@Param('court_id') court_id): Promise<Object> {
    return this.courtService.findCourt({ court_id });
  }

  @Post()
  @ApiOperation({ summary: '建立球場' })
  @UseGuards(JwtAuthGuard)
  @ApiHeader({ name: 'Authorization', description: 'JWT' })
  @ApiCreatedResponse({ type: Court })
  async addCourt(@Body() body: CourtDto): Promise<Object> {
    return await this.courtService.addCourt(body);
  }

  @Put('/:court_id')
  @ApiOperation({ summary: '修改球場' })
  @UseGuards(JwtAuthGuard)
  @ApiHeader({ name: 'Authorization', description: 'JWT' })
  @ApiOkResponse({ type: Court })
  async updateCourtById(@Param('court_id') court_id, @Body() body: CourtDto): Promise<Object> {
    let court = await this.courtService.updateCourtById(court_id, body);
    if (!court) throw new HttpException('user_id not found', HttpStatus.BAD_REQUEST)
    return court
  }

}
