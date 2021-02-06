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
  @UseGuards(JwtAuthGuard)
  async getMyTickets(@Req() req, @Query() query): Promise<Object> {
    return await this.gamesService.queryTicketsOfUserId(req.payload.user_id, query);
  }

  @Get('/:game_id')
  async getGameById(@Param('game_id') game_id): Promise<Object> {
    return await this.gamesService.findGame({ game_id });
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
    let game = await this.gamesService.findGame({ game_id })
    if (game.host_user_id !== req.payload.user_id)
      throw new HttpException('only admin or host user can update', HttpStatus.FORBIDDEN)

    body.host_user_id = req.payload.user_id
    return await this.gamesService.updateGame(game_id, body);
  }


  @Put('/:game_id/stock')
  @UseGuards(JwtAuthGuard)
  async updateGameStock(@Req() req, @Param('game_id') game_id, @Body() stockArr): Promise<Object> {
    let game = await this.gamesService.findGame({ game_id })
    if (game.host_user_id !== req.payload.user_id)
      throw new HttpException('only admin or host user can update', HttpStatus.FORBIDDEN)

    stockArr.forEach(stock => stock.game_id = game_id)

    return await this.gamesService.updateGameStock(stockArr);
  }

  @Post('/:game_id/game_user')
  @UseGuards(JwtAuthGuard)
  async joinGameByTicket(@Req() req, @Param('game_id') game_id, @Body() body): Promise<Object> {
    let game = await this.gamesService.findGame({ game_id })
    if (!game)
      throw new HttpException('game not found', HttpStatus.BAD_REQUEST)
    if (game.host_user_id !== req.payload.user_id)
      throw new HttpException('only admin or host user can create game user', HttpStatus.FORBIDDEN)

    let { game_ticket_id, game_user_id } = body
    let gameTicket = await this.gamesService.findGameTicket({ game_ticket_id })
    if (!gameTicket || gameTicket.game_id !== game_id)
      throw new HttpException('wrong game ticket id', HttpStatus.BAD_REQUEST)
    if (gameTicket.game_ticket_status === 'PAID')
      throw new HttpException('this ticket was used', HttpStatus.BAD_REQUEST)

    return await this.gamesService.joinGameByTicket(game_user_id, game, gameTicket);
  }

  @Get('/:game_id/game_user')
  @UseGuards(JwtAuthGuard)
  async queryGameUsers(@Param('game_id') game_id, @Query() query): Promise<Object> {
    return await this.gamesService.queryGameUsers(game_id, query);
  }

  @Post('/checkout')
  @UseGuards(JwtAuthGuard)
  async checkout(@Req() req, @Body() carts) {
    carts.forEach(d => d.owner_user_id = req.payload.user_id)
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
