import {
  Entity, PrimaryGeneratedColumn, CreateDateColumn, UpdateDateColumn,
  Column, ManyToOne, OneToMany, JoinColumn
} from "typeorm";
import { User } from './user.entity'
import { Court } from './court.entity'
import { GameStock } from './game_stock.entity'
import { ApiProperty } from '@nestjs/swagger';

export enum CourtType { INDOOR, COVERED, OUTDOOR }
export enum GameType { MALE_NET, FEMALE_NET_MIX, FEMAL_NET_PURE, BEACH }
export enum GameStatus { PENDING, PLAYING, FINISHED }

@Entity()
export class Game {

  @PrimaryGeneratedColumn("uuid")
  @ApiProperty()
  game_id: string;

  @Column({
    type: "varchar",
    length: 150,
  })
  @ApiProperty()
  game_name: string;

  @Column({
    type: "varchar",
  })
  @ApiProperty()
  host_user_id: string;

  @ManyToOne(() => User, user => user.user_id)
  @JoinColumn({ name: 'host_user_id' })
  @ApiProperty()
  host_user_detail: User;

  @Column({
    type: "varchar",
  })
  @ApiProperty()
  court_id: string;

  @ManyToOne(() => Court, court => court.court_id)
  @JoinColumn({ name: 'court_id' })
  @ApiProperty()
  court_detail: Court;

  @OneToMany(() => GameStock, gameStock => gameStock.game_detail)
  @ApiProperty({type: [GameStock]})
  game_stock: GameStock[]

  @Column({
    type: "timestamp",
  })
  @ApiProperty()
  game_start_at: Date;

  @Column({
    type: "timestamp",
  })
  @ApiProperty()
  game_end_at: Date;

  @Column({
    type: "timestamp",
  })
  @ApiProperty()
  sell_start_at: Date;

  @Column({
    type: "timestamp",
  })
  @ApiProperty()
  sell_end_at: Date;

  @Column({
    type: "integer",
    nullable: true
  })
  @ApiProperty()
  total_player_number: number;

  @Column({
    type: "varchar",
    enum: CourtType
  })
  @ApiProperty({ enum: CourtType })
  court_type: string;

  @Column({
    type: "varchar",
    enum: GameType
  })
  @ApiProperty({ enum: GameType })
  game_type: string;

  @Column({
    type: "varchar",
    nullable: true,
  })
  @ApiProperty()
  description: string;

  @Column({
    type: "varchar",
    enum: GameStatus,
    default: 'PENDING'
  })
  @ApiProperty({ enum: GameStatus })
  game_status: string;

  @Column({
    type: "jsonb",
    default: {}
  })
  @ApiProperty()
  meta: object;

  @Column({
    type: 'boolean',
  })
  @ApiProperty()
  is_public: boolean;

  @Column({
    type: 'boolean',
    default: false
  })
  @ApiProperty()
  deleted: boolean;

  @CreateDateColumn()
  @ApiProperty()
  created_at: Date;

  @UpdateDateColumn()
  @ApiProperty()
  updated_at: Date;

}
