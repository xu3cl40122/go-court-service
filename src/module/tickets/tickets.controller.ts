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
import { TicketsService } from './tickets.service';
import { UsersService } from '../users/users.service';
import { GamesService } from '../games/games.service';
import { JwtAuthGuard } from '../auth/jwt.guard';
import { ApiOkResponse, ApiCreatedResponse, ApiHeader, ApiTags, ApiOperation, ApiQuery, ApiBody } from '@nestjs/swagger';
import { getManyResponseFor } from '../../methods/spec'
import { GameTicket } from '../../entity/game_ticket.entity'
import { PageQueryDto } from '../../dto/query.dto'
import { TransferTicketDto } from '../../dto/ticket.dto'

@Controller('tickets')
@ApiTags('tickets')
export class TicketsController {
  constructor(
    private readonly ticketsService: TicketsService,
    private readonly gamesService: GamesService,
    private readonly usersService: UsersService) { }

  @Get('')
  @ApiOperation({ summary: '查詢登入帳號有的票券' })
  @UseGuards(JwtAuthGuard)
  @ApiHeader({ name: 'Authorization', description: 'JWT' })
  @ApiOkResponse({ type: getManyResponseFor(GameTicket) })
  async getMyTickets(@Req() req, @Query() query: PageQueryDto): Promise<Object> {
    return await this.ticketsService.queryTicketsOfUserId(req.payload.user_id, query);
  }

  @Get('/:game_ticket_id')
  @ApiOperation({ summary: '取得票券詳細資訊' })
  @UseGuards(JwtAuthGuard)
  @ApiHeader({ name: 'Authorization', description: 'JWT' })
  @ApiOkResponse({ type: GameTicket })
  async getTicketById(@Req() req, @Param('game_ticket_id') game_ticket_id): Promise<Object> {
    let user_id = req.payload.user_id
    let ticket = await this.ticketsService.findGameTicket({ game_ticket_id });
    if (!ticket)
      throw new HttpException('ticket not found', HttpStatus.BAD_REQUEST)
    if (ticket.owner_user_id !== user_id && ticket.game_detail.host_user_id !== user_id)
      throw new HttpException('only host of game or owner of ticket can access', HttpStatus.FORBIDDEN)
    return ticket
  }

  /**
   * 不知道怎麼寫 array 的 dto 先 hard code spec 解決
   */
  @Post('/checkout')
  @ApiOperation({ summary: '購買票券' })
  @UseGuards(JwtAuthGuard)
  @ApiBody({
    schema: {
      type: 'array',
      items: {
        default: {
          "stock_amount": 1,
          "game_stock_id": "7e72e5e5-17be-4efd-92dd-db6481ebe400"
        }
      }
    }
  })
  @ApiHeader({ name: 'Authorization', description: 'JWT' })
  @ApiOkResponse()
  async checkout(@Req() req, @Body() carts) {
    carts.forEach(d => d.owner_user_id = req.payload.user_id)
    let tickets

    try {
      tickets = await this.ticketsService.checkout(carts)
    } catch (error) {
      if (error.code === '23514')
        throw new HttpException('tickets sold out', HttpStatus.BAD_REQUEST)
      throw new HttpException('buy ticket failed', HttpStatus.INTERNAL_SERVER_ERROR)
    }

    return { tickets }
  }

  @Get('/games/:game_id/tickets')
  @ApiOperation({ summary: '查詢該比賽的票券' })
  @UseGuards(JwtAuthGuard)
  @ApiHeader({ name: 'Authorization', description: 'JWT' })
  @ApiOkResponse({ type: getManyResponseFor(GameTicket) })
  async queryGameTickets(@Param('game_id') game_id, @Query() query: PageQueryDto): Promise<Object> {
    return await this.ticketsService.queryGameTickets(game_id, query);
  }

  @Put('/:game_ticket_id/transfer')
  @ApiOperation({ summary: '轉票給其他 user' })
  @UseGuards(JwtAuthGuard)
  @ApiHeader({ name: 'Authorization', description: 'JWT' })
  @ApiOkResponse()
  async transferTicket(@Req() req, @Param('game_ticket_id') game_ticket_id, @Body() body: TransferTicketDto) {
    let sender_id = req.payload.user_id
    let receiver_id = body.receiver_id

    let [user, ticket] = await Promise.all([this.usersService.findUser({ user_id: receiver_id }), this.ticketsService.findGameTicket({ game_ticket_id })])
    if (!ticket)
      throw new HttpException('ticket not found', HttpStatus.BAD_REQUEST)
    if (!user)
      throw new HttpException('receiver not found', HttpStatus.BAD_REQUEST)
    if (ticket.owner_user_id !== sender_id)
      throw new HttpException('only owner of ticket can access', HttpStatus.FORBIDDEN)
    if (ticket.game_ticket_status !== 'PENDING')
      throw new HttpException("can't transfer ticket which ticket status isn't PENDING", HttpStatus.BAD_REQUEST)

    return await this.ticketsService.transferTicket(game_ticket_id, sender_id, receiver_id, ticket.meta)
  }

  // 驗證票券
  @Put('/games/:game_id/tickets/:game_ticket_id/verify')
  @ApiOperation({ summary: '球賽主辦者驗證參賽者票券(被驗證者會被加入該球賽 game user)' })
  @UseGuards(JwtAuthGuard)
  @ApiHeader({ name: 'Authorization', description: 'JWT' })
  @ApiOkResponse()
  async verifyTicket(@Req() req, @Param('game_id') game_id, @Param('game_ticket_id') game_ticket_id) {
    let [game, gameTicket] = await Promise.all([this.gamesService.findGame({ game_id }), this.ticketsService.findGameTicket({ game_ticket_id })])
    if (!game)
      throw new HttpException('wrong game_id', HttpStatus.BAD_REQUEST)
    if (game.host_user_id !== req.payload.user_id)
      throw new HttpException('only host user can verify ticket', HttpStatus.FORBIDDEN)
    if (!gameTicket || game.game_id !== gameTicket.game_id)
      throw new HttpException('wrong ticket', HttpStatus.BAD_REQUEST)

    return await this.ticketsService.verifyTicket(gameTicket)
  }

}
