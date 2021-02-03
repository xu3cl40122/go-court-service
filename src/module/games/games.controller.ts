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
import { GamesService } from './games.service';
import { JwtAuthGuard } from '../auth/jwt.guard';

@Controller('games')
export class GamesController {
  constructor(private readonly gamesService: GamesService) { }

  @Get()
  async queryGames(@Query() query): Promise<Object> {
    return await this.gamesService.queryGames(query);
  }

  @Get('/tickets')
  async getMyTickets(@Query() query): Promise<Object> {
    return await this.gamesService.queryGameTickets(query);
  }

  @Get('/:game_id')
  async getGameById(@Param('game_id') game_id): Promise<Object> {
    return await this.gamesService.findOne({ game_id });
  }
 
  @Post()
  @UseGuards(JwtAuthGuard)
  async addGame(@Req() req, @Body() body): Promise<Object> {
    body.host_user_id = req.payload.user_id
    return await this.gamesService.addGame(body);
  }

  @Put('/:game_id')
  @UseGuards(JwtAuthGuard)
  async updateGame(@Req() req, @Param('game_id') game_id, @Body() body): Promise<Object> {
    let game = await this.gamesService.findOne({ game_id })
    if (game.host_user_id !== req.payload.user_id)
      throw new HttpException('only admin or host user can update', HttpStatus.FORBIDDEN)

    body.host_user_id = req.payload.user_id
    return await this.gamesService.updateGame(game_id, body);
  }

  @Put('/:game_id/stock')
  @UseGuards(JwtAuthGuard)
  async updateGameStock(@Req() req, @Param('game_id') game_id, @Body() stockArr): Promise<Object> {
    let game = await this.gamesService.findOne({ game_id })
    if (game.host_user_id !== req.payload.user_id)
      throw new HttpException('only admin or host user can update', HttpStatus.FORBIDDEN)

    stockArr.forEach(stock => stock.game_id = game_id)

    return await this.gamesService.updateGameStock(stockArr);
  }

  @Post('/checkout')
  @UseGuards(JwtAuthGuard)
  async checkout(@Req() req, @Param('game_id') game_id, @Body() carts) {
    carts.forEach(d => d.owner_user_id = req.payload.user_id )
    let tickets

    try {
      tickets = await this.gamesService.checkout(carts)
    } catch (error) {
      if (error.code === '23514')
        throw new HttpException('tickets sold out', HttpStatus.BAD_REQUEST)
      throw new HttpException('buy ticket failed', HttpStatus.INTERNAL_SERVER_ERROR)
    }

    return { tickets }
  }


}
