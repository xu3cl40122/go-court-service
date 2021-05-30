import { Injectable, Inject, forwardRef } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository, getManager, In, MoreThanOrEqual, LessThanOrEqual } from 'typeorm';
import { Game } from '../../entity/game.entity';
import { GameUser } from '../../entity/game_user.entity';
import { GameTicket } from '../../entity/game_ticket.entity';
import { GameStock } from '../../entity/game_stock.entity';
import { GameQueryDto } from '../../dto/query.dto';
import { ILike } from "typeorm";
import { CreateGameDto, UpdateGameDro } from '../../dto/game.dto'
import { Cron } from '@nestjs/schedule';

interface IBuyGameTicketBody {
  game_id: string,
  game_stock_id: string,
  owner_user_id: string,
  stock_amount: string,
}

@Injectable()
export class GamesService {
  constructor(
    @InjectRepository(Game) private gamesRepository: Repository<Game>,
    @InjectRepository(GameUser) private gameUsersRepository: Repository<GameUser>,
    @InjectRepository(GameTicket) private gameTicketsRepository: Repository<GameTicket>,
    @InjectRepository(GameStock) private gameStockRepository: Repository<GameStock>,

  ) { }

  // game part 
  async findGame(query: { game_id?: string }) {
    return await this.gamesRepository.findOne({
      where: query,
      relations: ["host_user_detail", "game_stock", "court_detail"],
    })
  }

  async queryGames(query: GameQueryDto): Promise<Object> {
    let [page, size] = [Number(query.page ?? 0), Number(query.size ?? 10)]
    let { city_code, dist_code, court_type, game_type, start, end, game_name, game_status } = query
    let where: any = {
      is_public: true,
      sell_start_at: LessThanOrEqual(new Date()),
    }

    if (court_type)
      where.court_type = In(court_type.split(','))
    if (game_type)
      where.game_type = In(game_type.split(','))
    if (start)
      where.game_start_at = MoreThanOrEqual(start)
    if (end)
      where.game_end_at = LessThanOrEqual(end)
    if (game_name)
      where.game_name = ILike(`%${game_name}%`)
    if (game_status)
      where.game_status = game_status

    let [content, total] = await this.gamesRepository.findAndCount({
      join: {
        alias: "game",
        leftJoinAndSelect: {
          court: "game.court_detail",
        }
      },
      where: qb => {
        // filter game 自己
        let sql = qb.where(where)
        // Filter join 來的 table
        if (city_code)
          sql = sql.andWhere('city_code = :city_code', { city_code })
        if (dist_code)
          sql = sql.andWhere('dist_code = :dist_code', { dist_code })
      },
      take: size,
      skip: page * size,
      relations: ["host_user_detail", "game_stock"],
      order: {
        created_at: "DESC"
      }
    })

    let totalPage = Math.ceil(total / size)
    return { content, page, size, total, totalPage }
  }

  async findGamesOfHost(host_user_id, query: { page?, size?}) {
    let [page, size] = [Number(query.page ?? 0), Number(query.size ?? 10)]
    let [content, total] = await this.gamesRepository.findAndCount({
      where: {
        host_user_id,
      },
      take: size,
      skip: page * size,
      relations: ["host_user_detail", "game_stock", "court_detail"],
    })
    let totalPage = Math.ceil(total / size)
    return { content, page, size, total, totalPage }
  }

  async findGameShouldClose(): Promise<Game[]> {
    let games = await this.gamesRepository.find({
      where: {
        game_status: 'PLAYING',
        game_end_at: LessThanOrEqual(new Date())
      }
    })

    return games
  }

  async addGame(gameData: CreateGameDto): Promise<Game> {
    const game = new Game();
    let columns = [
      'game_name',
      'host_user_id',
      'court_id',
      'game_start_at',
      'game_end_at',
      'sell_start_at',
      'sell_end_at',
      'total_player_number',
      'court_type',
      'game_type',
      'description',
      'is_public',
      'deleted',
      'meta',
    ]
    columns.forEach(key => game[key] = gameData[key])
    return await this.gamesRepository.save(game);
  }

  async updateGame(game_id: string, gameData: UpdateGameDro): Promise<Object> {
    const game = new Game();
    let columns = [
      'game_name',
      'host_user_id',
      'court_id',
      'game_start_at',
      'game_end_at',
      'sell_start_at',
      'sell_end_at',
      'total_player_number',
      'court_type',
      'game_type',
      'description',
      'is_public',
      'deleted',
      'meta',
    ]

    columns.forEach(key => gameData[key] != undefined ? game[key] = gameData[key] : null)
    let { raw } = await this.gamesRepository
      .createQueryBuilder()
      .update(Game)
      .set(game)
      .where("game_id = :game_id", { game_id })
      .returning('*')
      .execute();

    return raw?.[0]
  }

  async updateGameStock(stockArr: GameStock[]) {
    return await this.gameStockRepository.save(stockArr)
  }

  async closeGame(game_id: string) {
    return this.gamesRepository.update(game_id, { game_status: 'FINISHED' })
  }

  async initGame(game_id: string) {
    return this.gamesRepository.update(game_id, { game_status: 'PLAYING' })
  }

  // 關掉過期但沒關閉的球賽
  // 每天早上三點自動執行
  @Cron('0 0 3 * * *')
  async cleanGames() {
    let games = await this.findGameShouldClose()
    let apis = games.map(game => this.closeGame(game.game_id))
    return await Promise.all(apis)
  }

  // game user part
  async initGameUsers(game_id: string, game_users: GameUser[]) {
    return await getManager().transaction(async manager => {
      await manager.insert(GameUser, game_users)
      let ticket_ids = game_users.map(d => d.game_ticket_id)
      await manager
        .createQueryBuilder()
        .update(GameTicket)
        .set({ game_ticket_status: 'PLAYING' })
        .where({ game_ticket_id: In(ticket_ids) })
        .execute();

      await manager.update(Game, game_id, { game_status: 'PLAYING' })
    })
  }

  async queryGameUsers(game_id, query: GameQueryDto) {
    let [page, size] = [Number(query.page ?? 0), Number(query.size ?? 10)]
    let [content, total] = await this.gameUsersRepository.findAndCount({
      where: [{ game_id }],
      relations: ["game_ticket_detail", "game_stock_detail", 'game_user_detail'],
      take: size,
      skip: page * size,
      order: {
        created_at: "DESC"
      }
    })

    let totalPage = Math.ceil(total / size)
    return { content, page, size, total, totalPage }
  }

  async findGameUser(queryObj: { game_user_id?: string, game_ticket_id }) {
    let where: any = {}
    if (queryObj.game_user_id)
      where.game_user_id = queryObj.game_user_id
    if (queryObj.game_ticket_id)
      where.game_ticket_id = queryObj.game_ticket_id
    return await this.gameUsersRepository.findOne({
      where: where,
      relations: ['game_user_detail', 'game_ticket_detail']
    })
  }

  async addGameUsers(game_users: GameUser[]) {
    return this.gameUsersRepository.insert(game_users)
  }



}
