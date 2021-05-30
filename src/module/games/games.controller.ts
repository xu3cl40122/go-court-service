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
  Inject,
  forwardRef
} from '@nestjs/common';
import { GamesService } from './games.service';
import { UsersService } from '../users/users.service';
import { TicketsService } from '../tickets/tickets.service';
import { JwtAuthGuard } from '../auth/jwt.guard';
import { CreateGameDto } from '../../dto/game.dto'
import { ApiOkResponse, ApiCreatedResponse, ApiHeader, ApiTags, ApiOperation, ApiBody } from '@nestjs/swagger';
import { Game } from '../../entity/game.entity'
import { GameQueryDto, PageQueryDto } from '../../dto/query.dto'
import { getManyResponseFor } from '../../methods/spec'
import { GameUser } from '../../entity/game_user.entity';

@Controller('games')
@ApiTags('games')
export class GamesController {
  constructor(
    private readonly gamesService: GamesService,
    private readonly usersService: UsersService,
    private ticketsService: TicketsService) { }

  @Get()
  @ApiOperation({ summary: '查詢球賽' })
  @ApiOkResponse({ type: getManyResponseFor(Game) })
  async queryGames(@Query() query: GameQueryDto): Promise<Object> {
    return await this.gamesService.queryGames(query);
  }

  @Get('/host')
  @ApiOperation({ summary: '查詢登入者主辦的球賽' })
  @UseGuards(JwtAuthGuard)
  @ApiHeader({ name: 'Authorization', description: 'JWT' })
  @ApiOkResponse({ type: getManyResponseFor(Game) })
  async findGamesOfHost(@Req() req, @Query() query: PageQueryDto): Promise<Object> {
    let host_user_id = req.payload.user_id
    return await this.gamesService.findGamesOfHost(host_user_id, query);
  }

  @Get('/:game_id')
  @ApiOperation({ summary: '取得球賽詳細資訊' })
  @ApiOkResponse({ type: Game })
  async getGameById(@Param('game_id') game_id): Promise<Object> {
    return await this.gamesService.findGame({ game_id });
  }

  @Post()
  @ApiOperation({ summary: '建立球賽 entity' })
  @UseGuards(JwtAuthGuard)
  @ApiHeader({ name: 'Authorization', description: 'JWT' })
  @ApiCreatedResponse({ type: Game })
  async addGame(@Req() req, @Body() body: CreateGameDto): Promise<Game> {
    body.host_user_id = req.payload.user_id
    return await this.gamesService.addGame(body);
  }

  @Put('/:game_id')
  @ApiOperation({ summary: '修改球賽 entity' })
  @UseGuards(JwtAuthGuard)
  @ApiHeader({ name: 'Authorization', description: 'JWT' })
  @ApiCreatedResponse({ type: Game })
  async updateGame(@Req() req, @Param('game_id') game_id, @Body() body: CreateGameDto): Promise<Object> {
    let game = await this.gamesService.findGame({ game_id })
    if (game.host_user_id !== req.payload.user_id)
      throw new HttpException('only admin or host user can update', HttpStatus.FORBIDDEN)

    body.host_user_id = req.payload.user_id
    return await this.gamesService.updateGame(game_id, body);
  }

  @Put('/:game_id/stock')
  @ApiOperation({ summary: '修改球賽票券規格' })
  @UseGuards(JwtAuthGuard)
  @ApiHeader({ name: 'Authorization', description: 'JWT' })
  @ApiBody({
    schema: {
      type: 'array',
      items: {
        default: {
          "spec_name": '男生',
          "stock_amount": 12,
          "price": 150
        }
      }
    }
  })
  async updateGameStock(@Req() req, @Param('game_id') game_id, @Body() stockArr): Promise<Object> {
    let game = await this.gamesService.findGame({ game_id })
    if (!game)
      throw new HttpException('game not found', HttpStatus.BAD_REQUEST)
    if (game.host_user_id !== req.payload.user_id)
      throw new HttpException('only admin or host user can update', HttpStatus.FORBIDDEN)

    stockArr.forEach(stock => stock.game_id = game_id)

    return await this.gamesService.updateGameStock(stockArr);
  }

  @Get('/:game_id/game_users')
  @ApiOperation({ summary: '查詢該球賽參賽者' })
  @UseGuards(JwtAuthGuard)
  @ApiHeader({ name: 'Authorization', description: 'JWT' })
  @ApiOkResponse({ type: getManyResponseFor(GameUser) })
  async queryGameUsers(@Param('game_id') game_id, @Query() query: PageQueryDto): Promise<Object> {
    return await this.gamesService.queryGameUsers(game_id, query);
  }

  /**
   * todo update 被用到的 game ticket 的 status
   * @param req 
   * @param game_id 
   * @returns 
   */
  @Put('/:game_id/init')
  @ApiOperation({ summary: '球賽建立者啟用球賽(開放進場)' })
  @UseGuards(JwtAuthGuard)
  @ApiHeader({ name: 'Authorization', description: 'JWT' })
  async initGame(@Req() req, @Param('game_id') game_id) {
    let game = await this.gamesService.findGame({ game_id })
    if (!game)
      throw new HttpException('wrong game_id', HttpStatus.BAD_REQUEST)
    if (game.host_user_id !== req.payload.user_id)
      throw new HttpException('only admin or host user can init game', HttpStatus.FORBIDDEN)
    if (game.game_status !== 'PENDING')
      throw new HttpException('you can init game which game_status is not PENDING', HttpStatus.NOT_ACCEPTABLE)

    return await this.gamesService.initGame(game_id)
  }

  @Put('/:game_id/initGameUsers')
  @ApiOperation({ summary: '自動把購票者轉成 game user' })
  @UseGuards(JwtAuthGuard)
  @ApiHeader({ name: 'Authorization', description: 'JWT' })
  async initGameUser(@Req() req, @Param('game_id') game_id) {
    let game = await this.gamesService.findGame({ game_id })
    if (!game)
      throw new HttpException('wrong game_id', HttpStatus.BAD_REQUEST)
    if (game.host_user_id !== req.payload.user_id)
      throw new HttpException('only admin or host user can init game', HttpStatus.FORBIDDEN)

    let tickets = await this.ticketsService.getGameTickets(game_id, {})
    let idMap = {}
    let game_users = []
    tickets.forEach(ticket => {
      let { game_id, game_stock_id, game_ticket_id, owner_user_id } = ticket
      if (!idMap[owner_user_id]) {
        game_users.push({ game_id, game_stock_id, game_ticket_id, game_user_id: owner_user_id })
        idMap[owner_user_id] = ticket
      }
    })

    return await this.gamesService.initGameUsers(game_id, game_users)
      .catch(error => {
        console.log(error)
        throw new HttpException('init game failed', HttpStatus.INTERNAL_SERVER_ERROR)
      })
  }

  @Put('/:game_id/close')
  @ApiOperation({ summary: '關閉球賽' })
  @UseGuards(JwtAuthGuard)
  @ApiHeader({ name: 'Authorization', description: 'JWT' })
  async closeGame(@Req() req, @Param('game_id') game_id): Promise<Object> {
    let game = await this.gamesService.findGame({ game_id })
    if (!game)
      throw new HttpException('game not found', HttpStatus.BAD_REQUEST)
    if (game.host_user_id !== req.payload.user_id)
      throw new HttpException('only admin or host user can close game', HttpStatus.FORBIDDEN)

    return await this.gamesService.closeGame(game_id);
  }

  @Put('/admin/clean')
  @ApiOperation({ summary: '關閉所有已超過結束時間的球賽(有排程定時執行)' })
  @UseGuards(JwtAuthGuard)
  @ApiHeader({ name: 'Authorization', description: 'JWT' })
  async cleanGames(@Req() req): Promise<Object> {
    if (req.payload.user_role !== 'ADMIN')
      throw new HttpException('permission denied', HttpStatus.FORBIDDEN)

    return this.gamesService.cleanGames()
  }

}
