import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Game } from '../../entity/game.entity';
import { GameUser } from '../../entity/game_user.entity';
import { GameTicket } from '../../entity/game_ticket.entity';
import { GameStock } from '../../entity/game_stock.entity';

interface IGameQueryParams {
  court_type?: string,
  game_type?: string,
  page?: string | number,
  size?: string | number,
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
      relations: ["host_user_detail", "game_stock_detail"],
      order: {
        created_at: "DESC"
      }
    })

    return { content, page, size, total }
  }

  async findOne(queryObj: { game_id?: string }) {
    return await this.gamesRepository.findOne(queryObj)
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
}
