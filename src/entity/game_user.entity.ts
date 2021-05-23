import {
  Entity, PrimaryColumn, CreateDateColumn, UpdateDateColumn,
  Column, ManyToOne, OneToMany, OneToOne, JoinColumn, PrimaryGeneratedColumn
} from "typeorm";
import { User } from './user.entity'
import { Game } from './game.entity'
import { GameTicket } from './game_ticket.entity'
import { GameStock } from './game_stock.entity'
import { ApiProperty } from '@nestjs/swagger';


@Entity()
export class GameUser {
  constructor(params: { game_id, game_stock_id, game_ticket_id, game_user_id }) {
    let { game_id, game_stock_id, game_ticket_id, game_user_id } = params || {}
    this.game_id = game_id
    this.game_stock_id = game_stock_id
    this.game_ticket_id = game_ticket_id
    this.game_user_id = game_user_id
  }

  @PrimaryColumn("uuid")
  @ApiProperty()
  game_ticket_id: string;

  @OneToOne(() => GameTicket, gameTicket => gameTicket.game_ticket_id)
  @JoinColumn({ name: 'game_ticket_id' })
  @ApiProperty()
  game_ticket_detail: GameTicket;

  @Column("uuid")
  @ApiProperty()
  game_stock_id: string;

  @ManyToOne(() => GameStock, gameStock => gameStock.game_stock_id)
  @JoinColumn({ name: 'game_stock_id' })
  @ApiProperty()
  game_stock_detail: GameStock;

  @Column({
    type: "uuid",
    nullable: true
  })
  @ApiProperty()
  game_id: string;

  // 不知道為何要 join game 就會報 foreignkey 的錯 猜測是跟 game ticket 都用到 game_id ??
  // @ManyToOne(() => Game, game => game.game_id)
  // @JoinColumn({ name: 'game_id' })
  // game_detail: string

  @Column("uuid")
  @ApiProperty()
  game_user_id: string;

  @ManyToOne(() => User, user => user.user_id)
  @JoinColumn({ name: 'game_user_id' })
  @ApiProperty()
  game_user_detail: User;

  @CreateDateColumn()
  @ApiProperty()
  created_at: Date;

  @UpdateDateColumn()
  @ApiProperty()
  updated_at: Date;

}
