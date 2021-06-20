import {
  Entity, PrimaryGeneratedColumn, CreateDateColumn, UpdateDateColumn,
  Column, ManyToOne, Check, JoinColumn
} from "typeorm";
import { Game } from './game.entity'
import { UpdateGameDto } from '../dto/game.dto'
import { ApiProperty } from '@nestjs/swagger';


@Entity()
// 確保票不會被買到爆
@Check(`"stock_amount" >= 0`)
export class GameStock {
  @PrimaryGeneratedColumn("uuid")
  @ApiProperty()
  game_stock_id: string;

  @Column("uuid")
  @ApiProperty()
  game_id: string;

  @ManyToOne(() => Game, game => game.game_id)
  @JoinColumn({ name: 'game_id' })
  @ApiProperty()
  game_detail: UpdateGameDto

  @Column({
    type: "varchar",
    length: 100
  })
  @ApiProperty()
  spec_name: string;

  @Column('integer')
  @ApiProperty()
  stock_amount: number;

  @Column({
    type: "integer",
  })
  @ApiProperty()
  price: number;

  @CreateDateColumn()
  @ApiProperty()
  created_at: Date;

  @UpdateDateColumn()
  @ApiProperty()
  updated_at: Date;

}
