import {
  Entity, PrimaryGeneratedColumn, CreateDateColumn, UpdateDateColumn,
  Column, ManyToOne, OneToMany, OneToOne, JoinColumn
} from "typeorm";
import { User } from './user.entity'
import { Game } from './game.entity'


@Entity()
export class GameStock {
  @PrimaryGeneratedColumn("uuid")
  game_stock_id: string;

  @ManyToOne(() => Game, game => game.game_id)
  game_id: string

  @Column({
    type: "varchar",
    length: 100
  })
  spec_name: string;

  @Column({
    type: "integer",
  })
  stock_amount: number;

  @Column({
    type: "integer",
  })
  price: number;

  @CreateDateColumn()
  created_at: Date;

  @UpdateDateColumn()
  updated_at: Date;

}
