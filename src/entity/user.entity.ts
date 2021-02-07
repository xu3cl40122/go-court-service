import { Entity, PrimaryGeneratedColumn, CreateDateColumn, UpdateDateColumn, Column } from "typeorm";

export enum UserStatus { INITIAL, ENABLED, DISABLED }
export enum UserRoles { ADMIN, NORMAL_USER }

@Entity()
export class User {

	@PrimaryGeneratedColumn("uuid")
	user_id: string;

	@Column({
		type: "varchar",
		length: 150,
	})
	profile_name: string;

	@Column({
		type: "varchar",
		length: 150,
		unique: true,
	})
	email: string;

	@Column({
		type: "varchar",
		length: 150,
		select: false,
		nullable: true
	})
	password: string;

	@Column({
		type: "varchar",
		enum: UserStatus,
		default: "INITIAL",
		length: 50,
	})
	user_status: string;

	@Column({
		type: "varchar",
		enum: UserRoles,
		default: "NORMAL_USER",
		length: 50,
	})
	user_role: string;

	@CreateDateColumn()
	created_at: Date;

	@UpdateDateColumn()
	updated_at: Date;


}
