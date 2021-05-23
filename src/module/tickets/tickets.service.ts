import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository, getManager } from 'typeorm';
import { Game } from '../../entity/game.entity';
import { GameUser } from '../../entity/game_user.entity';
import { GameTicket } from '../../entity/game_ticket.entity';
import { GameStock } from '../../entity/game_stock.entity';
import { GameQueryDto } from '../../dto/query.dto';
import { GamesService } from '../games/games.service'

interface IBuyGameTicketBody {
  game_id: string,
  game_stock_id: string,
  owner_user_id: string,
  stock_amount: string,
}

@Injectable()
export class TicketsService {
  constructor(
    @InjectRepository(Game) private gamesRepository: Repository<Game>,
    @InjectRepository(GameUser) private gameUsersRepository: Repository<GameUser>,
    @InjectRepository(GameTicket) private gameTicketsRepository: Repository<GameTicket>,
    @InjectRepository(GameStock) private gameStockRepository: Repository<GameStock>,
    private gamesService: GamesService
  ) { }

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
    let { game_ticket_id, game_stock_id, game_id, owner_user_id } = gameTicket
    let oldGameUser = await this.gamesService.findGameUser({ game_ticket_id })
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


}
