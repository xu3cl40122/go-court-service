import {
  Entity, PrimaryColumn, CreateDateColumn, UpdateDateColumn,
  Column, ManyToOne, OneToMany, OneToOne, JoinColumn
} from "typeorm";
import { User } from './user.entity'
import { Game } from './game.entity'
import { GameTicket } from './game_ticket.entity'
import { GameStock } from './game_stock.entity'


@Entity()
export class GameUser {
  constructor(params: { game_id, game_stock_id, game_ticket_id, game_user_id }) {
    let { game_id, game_stock_id, game_ticket_id, game_user_id } = params || {}
    this.game_id = game_id
    this.game_stock_id = game_stock_id
    this.game_ticket_id = game_ticket_id
    this.game_user_id = game_user_id
  }

  @PrimaryColumn()
  @OneToOne(() => Game, game => game.game_id)
  game_id: string

  @Column("uuid")
  game_ticket_id: string;

  @OneToOne(() => GameTicket, GameTicket => GameTicket.game_ticket_id)
  @JoinColumn({ name: 'game_ticket_id' })
  game_ticket_detail: GameTicket;

  @Column("uuid")
  game_stock_id: string;

  @ManyToOne(() => GameStock, gameStock => gameStock.game_stock_id)
  @JoinColumn({ name: 'game_stock_id' })
  game_stock_detail: GameStock;

  @Column("uuid")
  game_user_id: string;

  @ManyToOne(() => User, user => user.user_id)
  @JoinColumn({ name: 'game_user_id' })
  game_user_detail: User;

  @CreateDateColumn()
  created_at: Date;

  @UpdateDateColumn()
  updated_at: Date;

}
