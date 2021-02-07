import {
  Entity, PrimaryGeneratedColumn, CreateDateColumn, UpdateDateColumn,
  Column, ManyToOne,
} from "typeorm";
import { User } from './user.entity'

export enum VerificationType { ENABLE_ACCOUNT, FORGOT_PASSWORD }

@Entity()
export class Verification {
  constructor(params: { user_id, verification_code, verification_type, expires_at }) {
    let { user_id, verification_code, verification_type, expires_at } = params || {}
    this.user_id = user_id
    this.verification_code = verification_code
    this.verification_type = verification_type
    this.expires_at = expires_at
  }

  @PrimaryGeneratedColumn("uuid")
  verification_id: string;

  @ManyToOne(() => User, user => user.user_id)
  user_id: string

  @Column({
    type: 'varchar',
    length: '50'
  })
  verification_code: string

  @Column({
    type: 'varchar',
    length: '50',
    enum: VerificationType
  })
  verification_type: string

  @Column({
    type: 'timestamp',
  })
  expires_at: Date

  @CreateDateColumn()
  created_at: Date;

  @UpdateDateColumn()
  updated_at: Date;

}
