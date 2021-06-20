import { Entity, PrimaryGeneratedColumn, CreateDateColumn, UpdateDateColumn, Column, OneToMany } from "typeorm";
export enum CourtOpenStatus { FREE, CLOSE, PAID }
import { ApiProperty } from '@nestjs/swagger'

@Entity()
export class Court {

  @PrimaryGeneratedColumn()
  @ApiProperty()
  court_id: number;

  @Column({
    type: "varchar",
    length: 150,
  })
  @ApiProperty()
  name: string;

  @Column({
    type: "varchar",
    length: 150,
  })
  @ApiProperty()
  address: string;

  @Column({
    type: "varchar",
    length: 20,
    nullable: true,
  })
  @ApiProperty()
  city_code: string;

  @Column({
    type: "varchar",
    length: 20,
    nullable: true,
  })
  @ApiProperty()
  dist_code: string;

  @Column({
    type: "numeric",
    nullable: true,
  })
  @ApiProperty()
  latitude: number;

  @Column({
    type: "numeric",
    nullable: true,
  })
  @ApiProperty()
  longitude: number;

  @Column({
    type: "varchar",
    length: 50,
    nullable: true,
  })
  @ApiProperty()
  phone: string;

  @Column({
    type: "varchar",
    nullable: true,
  })
  @ApiProperty()
  logo_url: string;

  @Column({
    type: "varchar",
    nullable: true,
  })
  @ApiProperty()
  description: string;

  @Column({
    type: "varchar",
    enum: CourtOpenStatus,
  })
  @ApiProperty()
  open_status: string;

  @Column({
    type: 'geometry',
    nullable: true,
    spatialFeatureType: 'Point',
    srid: 4326
  })
  @ApiProperty()
  geometry: object;

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
