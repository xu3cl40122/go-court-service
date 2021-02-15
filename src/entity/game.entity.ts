import {
  Entity, PrimaryGeneratedColumn, CreateDateColumn, UpdateDateColumn,
  Column, ManyToOne, OneToMany, JoinColumn
} from "typeorm";
import { User } from './user.entity'
import { Court } from './court.entity'
import { GameStock } from './game_stock.entity'

export enum CourtType { INDOOR, COVERED, OUTDOOR }
export enum GameType { MALE_NET, FEMALE_NET_MIX, FEMAL_NET_PURE, BEACH }
export enum GameStatus { PENDING, PLAYING, FINISHED }

@Entity()
export class Game {

  @PrimaryGeneratedColumn("uuid")
  game_id: string;

  @Column({
    type: "varchar",
    length: 150,
  })
  game_name: string;

  @Column({
    type: "varchar",
  })
  host_user_id: string;

  @ManyToOne(() => User, user => user.user_id)
  @JoinColumn({ name: 'host_user_id' })
  host_user_detail: User;

  @Column({
    type: "varchar",
  })
  court_id: string;

  @ManyToOne(() => Court, court => court.court_id)
  @JoinColumn({ name: 'court_id' })
  court_detail: string;

  @OneToMany(() => GameStock, gameStock => gameStock.game_detail)
  game_stock: GameStock[]

  @Column({
    type: "timestamp",
  })
  game_start_at: Date;

  @Column({
    type: "timestamp",
  })
  game_end_at: Date;

  @Column({
    type: "timestamp",
  })
  sell_start_at: Date;

  @Column({
    type: "timestamp",
  })
  sell_end_at: Date;

  @Column({
    type: "integer",
    nullable: true
  })
  total_player_number: number;

  @Column({
    type: "varchar",
    enum: CourtType
  })
  court_type: string;

  @Column({
    type: "varchar",
    enum: GameType
  })
  game_type: string;

  @Column({
    type: "varchar",
    nullable: true,
  })
  description: string;

  @Column({
    type: "varchar",
    enum: GameStatus,
    default: 'PENDING'
  })
  game_status: string;

  @Column({
    type: "jsonb",
    default: {}
  })
  meta: object;

  @Column("boolean")
  is_public: boolean;

  @Column("boolean")
  deleted: boolean;

  @CreateDateColumn()
  created_at: Date;

  @UpdateDateColumn()
  updated_at: Date;

}
