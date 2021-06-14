import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository, getManager } from 'typeorm';
import { Game } from '../../entity/game.entity';
import { GameUser } from '../../entity/game_user.entity';
import { GameTicket } from '../../entity/game_ticket.entity';
import { GameStock } from '../../entity/game_stock.entity';
import { PageQueryDto, TicketQueryDto } from '../../dto/query.dto';
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
    @InjectRepository(GameTicket) private gameTicketsRepository: Repository<GameTicket>,
    @InjectRepository(GameStock) private gameStockRepository: Repository<GameStock>,
    private gamesService: GamesService
  ) { }

  // ticket part
  async checkout(carts: IBuyGameTicketBody[]): Promise<GameTicket[]> {
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

  async findGameStock(game_stock_id: string): Promise<GameStock> {
    return await this.gameStockRepository.findOne({
      where: { game_stock_id },
      relations: ['game_detail']
    })
  }

  // 找到所有票券(不分頁)
  async getGameTickets(game_id, option: { relations?: string[] }) {
    return await this.gameTicketsRepository.find({
      where: [{ game_id }],
      relations: option.relations,
      order: {
        created_at: "DESC"
      }
    })
  }

  async queryGameTickets(query: TicketQueryDto, relations = ["game_stock_detail", 'owner_user_detail']) {
    let [page, size] = [Number(query.page ?? 0), Number(query.size ?? 10)]
    let condition: any = {}
    let { game_id, owner_user_id, game_ticket_status } = query
    if (game_id)
      condition.game_id = game_id
    if (owner_user_id)
      condition.owner_user_id = owner_user_id
    if (game_ticket_status)
      condition.game_ticket_status = game_ticket_status

    let [content, total] = await this.gameTicketsRepository.findAndCount({
      where: condition,
      relations: relations,
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
  }

  async transferTicket(game_ticket_id: string, sender_id: string, receiver_id: string, meta: any = {}): Promise<object> {
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
