import {
  Entity, PrimaryGeneratedColumn, CreateDateColumn, UpdateDateColumn,
  Column, ManyToOne, OneToMany, OneToOne, JoinColumn
} from "typeorm";
import { ApiProperty } from '@nestjs/swagger';
import { User } from './user.entity'
import { Game } from './game.entity'
import { GameStock } from './game_stock.entity'
import { UpdateGameDto } from '../dto/game.dto'

export enum GameTicketStatus { PENDING, PLAYING, VERIFIED }


@Entity()
export class GameTicket {
  constructor(params: { game_id, game_stock_id, owner_user_id, game_ticket_status?}) {
    let { game_id, game_stock_id, owner_user_id, game_ticket_status } = params || {}
    this.game_id = game_id
    this.game_stock_id = game_stock_id
    this.owner_user_id = owner_user_id

    game_ticket_status ? this.game_ticket_status = game_ticket_status : null
  }
  @PrimaryGeneratedColumn("uuid")
  @ApiProperty()
  game_ticket_id: string;

  @Column("uuid")
  @ApiProperty()
  game_id: string;

  @ManyToOne(() => Game, game => game.game_id)
  @JoinColumn({ name: 'game_id' })
  @ApiProperty()
  game_detail: UpdateGameDto

  @Column("uuid")
  @ApiProperty()
  game_stock_id: string;

  @ManyToOne(() => GameStock, game_stock => game_stock.game_stock_id)
  @JoinColumn({ name: 'game_stock_id' })
  @ApiProperty()
  game_stock_detail: GameStock;

  @Column("uuid")
  @ApiProperty()
  owner_user_id: string

  @ManyToOne(() => User, user => user.user_id)
  @JoinColumn({ name: 'owner_user_id' })
  @ApiProperty()
  owner_user_detail: User;

  @Column({
    type: "varchar",
    enum: GameTicketStatus,
    default: 'PENDING'
  })
  @ApiProperty({ enum: GameTicketStatus })
  game_ticket_status: string;

  @Column({
    type: 'boolean',
    default: false
  })
  @ApiProperty()
  isPaid: boolean

  @Column({
    type: "jsonb",
    default: {}
  })
  @ApiProperty()
  meta: object;

  @CreateDateColumn()
  @ApiProperty()
  created_at: Date;

  @UpdateDateColumn()
  @ApiProperty()
  updated_at: Date;

}
