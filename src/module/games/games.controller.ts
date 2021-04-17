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

  // get 我有的票
  @Get('/tickets')
  @UseGuards(JwtAuthGuard)
  async getMyTickets(@Req() req, @Query() query): Promise<Object> {
    return await this.gamesService.queryTicketsOfUserId(req.payload.user_id, query);
  }
  // get 票 by id
  @Get('/tickets/:game_ticket_id')
  @UseGuards(JwtAuthGuard)
  async getTicketById(@Req() req, @Param('game_ticket_id') game_ticket_id): Promise<Object> {
    let user_id = req.payload.user_id
    let ticket = await this.gamesService.findGameTicket({ game_ticket_id });
    if (!ticket)
      throw new HttpException('ticket not found', HttpStatus.BAD_REQUEST)
    if (ticket.owner_user_id !== user_id && ticket.game_detail.host_user_id)
      throw new HttpException('only host of game or owner of ticket can access', HttpStatus.FORBIDDEN)
    return ticket
  }

  // get 我主辦的比賽
  @Get('/host')
  @UseGuards(JwtAuthGuard)
  async findGamesOfHost(@Req() req, @Query() query): Promise<Object> {
    let host_user_id = req.payload.user_id
    return await this.gamesService.findGamesOfHost(host_user_id, query);
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

  // update game 票券規格
  @Put('/:game_id/stock')
  @UseGuards(JwtAuthGuard)
  async updateGameStock(@Req() req, @Param('game_id') game_id, @Body() stockArr): Promise<Object> {
    let game = await this.gamesService.findGame({ game_id })
    if (!game)
      throw new HttpException('game not found', HttpStatus.BAD_REQUEST)
    if (game.host_user_id !== req.payload.user_id)
      throw new HttpException('only admin or host user can update', HttpStatus.FORBIDDEN)

    stockArr.forEach(stock => stock.game_id = game_id)

    return await this.gamesService.updateGameStock(stockArr);
  }

  // @Post('/:game_id/game_user')
  // @UseGuards(JwtAuthGuard)
  // async joinGameByTicket(@Req() req, @Param('game_id') game_id, @Body() body): Promise<Object> {
  //   let game = await this.gamesService.findGame({ game_id })
  //   if (!game)
  //     throw new HttpException('game not found', HttpStatus.BAD_REQUEST)
  //   if (game.host_user_id !== req.payload.user_id)
  //     throw new HttpException('only admin or host user can create game user', HttpStatus.FORBIDDEN)

  //   let { game_ticket_id, game_user_id } = body
  //   let gameTicket = await this.gamesService.findGameTicket({ game_ticket_id })
  //   if (!gameTicket || gameTicket.game_id !== game_id)
  //     throw new HttpException('wrong game ticket id', HttpStatus.BAD_REQUEST)
  //   if (gameTicket.game_ticket_status === 'PAID')
  //     throw new HttpException('this ticket was used', HttpStatus.BAD_REQUEST)

  //   return await this.gamesService.joinGameByTicket(game_user_id, game, gameTicket);
  // }

  @Get('/:game_id/game_users')
  @UseGuards(JwtAuthGuard)
  async queryGameUsers(@Param('game_id') game_id, @Query() query): Promise<Object> {
    return await this.gamesService.queryGameUsers(game_id, query);
  }

  @Get('/:game_id/tickets')
  @UseGuards(JwtAuthGuard)
  async queryGameTickets(@Param('game_id') game_id, @Query() query): Promise<Object> {
    return await this.gamesService.queryGameTickets(game_id, query);
  }

  /**
   * todo update 被用到的 game ticket 的 status
   * @param req 
   * @param game_id 
   * @returns 
   */
  @Put('/:game_id/init')
  @UseGuards(JwtAuthGuard)
  async initGame(@Req() req, @Param('game_id') game_id) {
    let game = await this.gamesService.findGame({ game_id })
    if (!game)
      throw new HttpException('wrong game_id', HttpStatus.BAD_REQUEST)
    if (game.host_user_id !== req.payload.user_id)
      throw new HttpException('only admin or host user can init game', HttpStatus.FORBIDDEN)
    // if (game.game_status !== 'PENDING')
    //   throw new HttpException('you can init game which game_status is not PENDING', HttpStatus.NOT_ACCEPTABLE)
    let tickets = await this.gamesService.getGameTickets(game_id, {})
    let idMap = {}
    let game_users = []
    tickets.forEach(ticket => {
      let { game_id, game_stock_id, game_ticket_id, owner_user_id } = ticket
      if (!idMap[owner_user_id]) {
        game_users.push({ game_id, game_stock_id, game_ticket_id, game_user_id: owner_user_id })
        idMap[owner_user_id] = ticket
      }
    })

    return await this.gamesService.initGame(game_id, game_users)
      .catch(error => {
        console.log(error)
        throw new HttpException('init game failed', HttpStatus.INTERNAL_SERVER_ERROR)
      })
  }

  // 驗證票券
  @Put('/:game_id/tickets/:game_ticket_id/verify')
  @UseGuards(JwtAuthGuard)
  async verifyTicket(@Req() req, @Param('game_id') game_id, @Param('game_ticket_id') game_ticket_id) {
    let [game, gameTicket] = await Promise.all([this.gamesService.findGame({ game_id }), this.gamesService.findGameTicket({ game_ticket_id })])
    if (!game)
      throw new HttpException('wrong game_id', HttpStatus.BAD_REQUEST)
    if (game.host_user_id !== req.payload.user_id)
      throw new HttpException('only admin or host user can verify ticket', HttpStatus.FORBIDDEN)
    if (!gameTicket || game.game_id !== gameTicket.game_id)
      throw new HttpException('wrong ticket', HttpStatus.BAD_REQUEST)

    return await this.gamesService.verifyTicket(gameTicket.game_ticket_id)
  }

  // 結帳票券
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
