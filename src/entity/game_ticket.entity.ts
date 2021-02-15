import {
  Entity, PrimaryGeneratedColumn, CreateDateColumn, UpdateDateColumn,
  Column, ManyToOne, OneToMany, OneToOne, JoinColumn
} from "typeorm";
import { User } from './user.entity'
import { Game } from './game.entity'
import { GameStock } from './game_stock.entity'

export enum GameTicketStatus { PENDING, VERIFIED }


@Entity()
export class GameTicket {
  constructor(params: { game_id, game_stock_id, owner_user_id }) {
    let { game_id, game_stock_id, owner_user_id } = params || {}
    this.game_id = game_id
    this.game_stock_id = game_stock_id
    this.owner_user_id = owner_user_id
  }
  @PrimaryGeneratedColumn("uuid")
  game_ticket_id: string;

  @Column("uuid")
  game_id: string;

  @ManyToOne(() => Game, game => game.game_id)
  @JoinColumn({ name: 'game_id' })
  game_detail: string

  @Column("uuid")
  game_stock_id: string;

  @ManyToOne(() => GameStock, game_stock => game_stock.game_stock_id)
  @JoinColumn({ name: 'game_stock_id' })
  game_stock_detail: User;

  @Column("uuid")
  owner_user_id: string

  @ManyToOne(() => User, user => user.user_id)
  @JoinColumn({ name: 'owner_user_id' })
  owner_user_detail: User;

  @Column({
    type: "varchar",
    enum: GameTicketStatus,
    default: 'PENDING'
  })
  game_ticket_status: string;

  @Column({
    type: 'boolean',
    default: false
  })
  isPaid: boolean

  @CreateDateColumn()
  created_at: Date;

  @UpdateDateColumn()
  updated_at: Date;

}
