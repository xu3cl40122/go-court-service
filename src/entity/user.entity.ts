import { Entity, PrimaryGeneratedColumn, CreateDateColumn, UpdateDateColumn, Column } from "typeorm";

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

	@CreateDateColumn()
	created_at: Date;

	@UpdateDateColumn()
	updated_at: Date;


}
