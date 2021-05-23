import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository, getManager, In, MoreThanOrEqual, LessThanOrEqual } from 'typeorm';
import { Game } from '../../entity/game.entity';
import { GameUser } from '../../entity/game_user.entity';
import { GameTicket } from '../../entity/game_ticket.entity';
import { GameStock } from '../../entity/game_stock.entity';
import { GameQueryDto } from '../../dto/query.dto';
import { ILike } from "typeorm";
import { CreateGameDto } from '../../dto/game.dto'

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
    let { city_code, dist_code, court_type, game_type, start, end, game_name } = query
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
    if (query.game_name)
      where.game_name = ILike(`%${query.game_name}%`)

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

  async updateGame(game_id: string, gameData: CreateGameDto): Promise<Object> {
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

  // ticket part
  async checkout(carts: IBuyGameTicketBody[]) {
    let resArr = []
    await getManager().transaction(async manager => {
      for (let cartItem of carts) {
        let { game_stock_id, stock_amount, owner_user_id } = cartItem
        let { raw, affected } = await manager.createQueryBuilder()
          .update(GameStock)
          .set({ stock_amount: () => `stock_amount - ${stock_amount}` })
          .where("game_stock_id = :game_stock_id", { game_stock_id })
          .returning('*')
          .execute()
        if (affected !== 1) throw 'wrong stock_id'

        let { game_id } = raw[0]
        let gameTicketArr = Array(stock_amount).fill('').map(d => {
          return new GameTicket({ game_id, game_stock_id, owner_user_id })
        })
        let newTickets = await manager.save(gameTicketArr)
        resArr.push(...newTickets)
      }

    });
    return resArr
  }

  async findGameTicket(queryObj: { game_ticket_id?: string }) {
    return await this.gameTicketsRepository.findOne({
      where: [{ game_ticket_id: queryObj.game_ticket_id }],
      relations: ['game_stock_detail', 'owner_user_detail']
    })
  }

  async queryTicketsOfUserId(owner_user_id, reqQuery: GameQueryDto): Promise<Object> {
    let [page, size] = [Number(reqQuery.page ?? 0), Number(reqQuery.size ?? 10)]

    let [content, total] = await this.gameTicketsRepository.findAndCount({
      take: size,
      skip: page * size,
      relations: ['game_detail', 'game_detail.court_detail', 'game_stock_detail'],
      where: [{ owner_user_id }],
      order: {
        created_at: 'DESC'
      }
    })

    let totalPage = Math.ceil(total / size)
    return { content, page, size, total, totalPage }
  }

  async getGameTickets(game_id, option: { relations?: string[] }) {
    return await this.gameTicketsRepository.find({
      where: [{ game_id }],
      relations: option.relations,
      order: {
        created_at: "DESC"
      }
    })
  }

  async queryGameTickets(game_id, query: GameQueryDto) {
    let [page, size] = [Number(query.page ?? 0), Number(query.size ?? 10)]
    let [content, total] = await this.gameTicketsRepository.findAndCount({
      where: [{ game_id }],
      relations: ["game_stock_detail", 'owner_user_detail'],
      take: size,
      skip: page * size,
      order: {
        created_at: "DESC"
      }
    })

    let totalPage = Math.ceil(total / size)
    return { content, page, size, total, totalPage }
  }

  async verifyTicket(gameTicket: GameTicket) {
    let { game_ticket_id, game_stock_id, game_id, owner_user_id} = gameTicket
    let oldGameUser = await this.findGameUser({ game_ticket_id})
    return await getManager().transaction(async manager => {
      await manager.createQueryBuilder()
        .update(GameTicket)
        .set({ game_ticket_status: 'VERIFIED' })
        .where("game_ticket_id = :game_ticket_id", { game_ticket_id })
        .execute()
      if (oldGameUser) return
      let gameUser = new GameUser({ game_id, game_stock_id, game_ticket_id, game_user_id: owner_user_id })
      return await manager.save(gameUser)
    })
    // return this.gameTicketsRepository.update(game_ticket_id, { game_ticket_status: 'VERIFIED' })
  }

  async transferTicket(game_ticket_id: string, sender_id: string, receiver_id: string, meta: any = {}) {
    if (!meta.transfer_record) meta.transfer_record = []
    meta.transfer_record.push({ from: sender_id, to: receiver_id, updated_at: new Date().getTime() })
    return this.gameTicketsRepository.update(game_ticket_id, { owner_user_id: receiver_id, meta })
  }

  async joinGameByTicket(game_user_id, game: Game, gameTicket: GameTicket): Promise<Object> {
    let { game_stock_id, game_ticket_id } = gameTicket
    let { game_id } = game
    return await getManager().transaction(async manager => {
      await manager.createQueryBuilder()
        .update(GameTicket)
        .set({ game_ticket_status: 'PAID' })
        .where("game_ticket_id = :game_ticket_id", { game_ticket_id })
        .execute()

      let gameUser = new GameUser({ game_id, game_stock_id, game_ticket_id, game_user_id })
      return await manager.save(gameUser)
    })

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
    let where:any = {}
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
