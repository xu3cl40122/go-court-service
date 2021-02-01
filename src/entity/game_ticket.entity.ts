import {
  Entity, PrimaryGeneratedColumn, CreateDateColumn, UpdateDateColumn,
  Column, ManyToOne, OneToMany, OneToOne, JoinColumn
} from "typeorm";
import { User } from './user.entity'
import { Game } from './game.entity'
import { GameStock } from './game_stock.entity'


@Entity()
export class GameTicket {
  @PrimaryGeneratedColumn("uuid")
  game_ticket_id: string;

  @OneToOne(() => Game, game => game.game_id)
  game_id: string

  @Column("uuid")
  game_stock_id: string;

  @ManyToOne(() => GameStock, game_stock => game_stock.game_stock_id)
  @JoinColumn({ name: 'game_stock_id' })
  game_stock_detail: User;

  @OneToOne(() => User, user => user.user_id)
  owner_user_id: string

  @ManyToOne(() => User, user => user.user_id)
  @JoinColumn({ name: 'owner_user_id' })
  owner_user_detail: User;

  @Column({
    type: "varchar",
    nullable: true
  })
  spec_name: string;

  @CreateDateColumn()
  created_at: Date;

  @UpdateDateColumn()
  updated_at: Date;

}
