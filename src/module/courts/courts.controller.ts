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

@Controller('courts')
export class CourtController {
  constructor(
    private readonly courtService: CourtService
  ) { }

  @Get()
  @UseGuards(JwtAuthGuard)
  async queryCourts(@Query() query): Promise<Object> {
    return this.courtService.queryCourts(query);
  }

  @Get('/:court_id')
  @UseGuards(JwtAuthGuard)
  async getGameById(@Param('court_id') court_id): Promise<Object> {
    return this.courtService.findCourt({ court_id });
  }

  @Post()
  @UseGuards(JwtAuthGuard)
  async addCourt(@Body() body): Promise<Object> {
    return await this.courtService.addCourt(body);
  }

  @Put('/:court_id')
  @UseGuards(JwtAuthGuard)
  async updateCourtById(@Param('court_id') court_id, @Body() body): Promise<Object> {
    let court = await this.courtService.updateCourtById(court_id, body);
    if (!court) throw new HttpException('user_id not found', HttpStatus.BAD_REQUEST)
    return court
  }

}
