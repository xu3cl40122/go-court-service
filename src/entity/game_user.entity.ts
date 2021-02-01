import {
  Entity, PrimaryColumn, CreateDateColumn, UpdateDateColumn,
  Column, ManyToOne, OneToMany, OneToOne, JoinColumn
} from "typeorm";
import { User } from './user.entity'
import { Game } from './game.entity'

export enum GameUserStatus { PENDING, PAID }

@Entity()
export class GameUser {
  
  @PrimaryColumn()
  @OneToOne(() => Game, game => game.game_id)
  game_id: string

  @Column("uuid")
  game_user_id: string;

  @ManyToOne(() => User, user => user.user_id)
  @JoinColumn({ name: 'game_user_detail' })
  game_user_detail: User;

  @Column({
    type: "varchar",
    enum: GameUserStatus,
    default: 'PENDING'
  })
  game_user_status: string;

  @CreateDateColumn()
  created_at: Date;

  @UpdateDateColumn()
  updated_at: Date;

}
