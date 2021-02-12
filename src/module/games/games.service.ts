import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { getManager } from "typeorm";
import { Game } from '../../entity/game.entity';
import { GameUser } from '../../entity/game_user.entity';
import { GameTicket } from '../../entity/game_ticket.entity';
import { GameStock } from '../../entity/game_stock.entity';
import { IPageQuery } from '../../interface/index';

interface IGameQueryParams extends IPageQuery {
  court_type?: string,
  game_type?: string,
}

interface IBuyGameTicketBody {
  game_id: string,
  game_stock_id: string,
  owner_user_id: string,
  stock_amount: number,
}

@Injectable()
export class GamesService {
  constructor(
    @InjectRepository(Game) private gamesRepository: Repository<Game>,
    @InjectRepository(GameUser) private gameUsersRepository: Repository<GameUser>,
    @InjectRepository(GameTicket) private gameTicketsRepository: Repository<GameTicket>,
    @InjectRepository(GameStock) private gameStockRepository: Repository<GameStock>,
  ) { }

  async queryGames(reqQuery: IGameQueryParams): Promise<Object> {
    let [page, size] = [Number(reqQuery.page ?? 0), Number(reqQuery.size ?? 10)]
    let where = {}
    let filters = ['court_type', 'game_type']
    filters.forEach(key => reqQuery[key] ? where[key] = reqQuery[key] : '')

    let [content, total] = await this.gamesRepository.findAndCount({
      where,
      take: size,
      skip: page * size,
      relations: ["host_user_detail", "game_stock"],
      order: {
        created_at: "DESC"
      }
    })

    return { content, page, size, total }
  }

  async findGame(queryObj: { game_id?: string }) {
    return await this.gamesRepository.findOne(queryObj)
  }

  async queryTicketsOfUserId(owner_user_id, reqQuery: IPageQuery): Promise<Object> {
    let [page, size] = [Number(reqQuery.page ?? 0), Number(reqQuery.size ?? 10)]

    let [content, total] = await this.gameTicketsRepository.findAndCount({
      take: size,
      skip: page * size,
      relations: ['game_detail', 'game_stock_detail'],
      where: [{ owner_user_id }],
      order: {
        created_at: 'DESC'
      }
    })

    return { content, page, size, total }
  }

  async findGameTicket(queryObj: { game_ticket_id?: string }) {
    return await this.gameTicketsRepository.findOne(queryObj)
  }

  async addGame(gameData: Game): Promise<Object> {
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
    ]
    columns.forEach(key => game[key] = gameData[key])
    return await this.gamesRepository.save(game);
  }

  async updateGame(game_id: string, gameData: Game): Promise<Object> {
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
    ]

    columns.forEach(key => game[key] = gameData[key])
    let { raw } = await this.gamesRepository
      .createQueryBuilder()
      .update(Game)
      .set(game)
      .where("game_id = :game_id", { game_id })
      .returning('*')
      .execute();

    raw.forEach(user => delete user.email)
    return raw?.[0]
  }

  async updateGameStock(stockArr: GameStock[]) {
    return await this.gameStockRepository.save(stockArr)
  }

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

  async queryGameUsers(game_id, query: IPageQuery) {
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

    return { content, page, size, total }
  }

}
