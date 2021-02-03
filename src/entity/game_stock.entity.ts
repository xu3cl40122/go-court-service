import {
  Entity, PrimaryGeneratedColumn, CreateDateColumn, UpdateDateColumn,
  Column, ManyToOne, Check
} from "typeorm";
import { Game } from './game.entity'


@Entity()
@Check(`"stock_amount" > 0`)
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

  @Column('integer')
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
