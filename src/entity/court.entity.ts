import { Entity, PrimaryGeneratedColumn, CreateDateColumn, UpdateDateColumn, Column, OneToMany } from "typeorm";
import { Game } from './game.entity'
export enum CourtOpenStatus { FREE, CLOSE, PAID }

@Entity()
export class Court {

  @PrimaryGeneratedColumn()
  court_id: number;

  @Column({
    type: "varchar",
    length: 150,
  })
  name: string;

  @Column({
    type: "varchar",
    length: 150,
  })
  address: string;

  @Column({
    type: "varchar",
    length: 20,
    nullable: true,
  })
  city_code: string;

  @Column({
    type: "varchar",
    length: 20,
    nullable: true,
  })
  dist_code: string;

  @Column({
    type: "numeric",
    nullable: true,
  })
  latitude: number;

  @Column({
    type: "numeric",
    nullable: true,
  })
  longitude: number;

  @Column({
    type: "varchar",
    length: 50,
    nullable: true,
  })
  phone: string;

  @Column({
    type: "varchar",
    nullable: true,
  })
  logo_url: string;

  @Column({
    type: "varchar",
    nullable: true,
  })
  description: string;

  @Column({
    type: "varchar",
    enum: CourtOpenStatus,
  })
  open_status: string;

  @Column({
    type: 'geometry',
    nullable: true,
    spatialFeatureType: 'Point',
    srid: 4326
  })
  geometry: object;

  @Column({
    type: "jsonb",
    default: {}
  })
  meta: object;

  @CreateDateColumn()
  created_at: Date;

  @UpdateDateColumn()
  updated_at: Date;


}
