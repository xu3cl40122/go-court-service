import { Entity, PrimaryGeneratedColumn, CreateDateColumn, UpdateDateColumn, Column } from "typeorm";


@Entity()
export class File {

	@PrimaryGeneratedColumn("uuid")
	file_id: string;

	@Column({
		type: "varchar",
		length: 150,
	})
	file_name: string;

	@Column({
		type: "varchar",
		length: 150,
		nullable: true
	})
	tag: string;

	@Column({
		type: "varchar",
		length: 300,
		nullable: true
	})
	file_url: string;

	@Column({
		type: "varchar",
		length: 300,
	})
	created_by: string;

	@Column({
		type: "varchar",
		length: 300,
	})
	reference_id: string;

	@Column({
		type: "boolean",
		default: true
	})
	is_public: boolean;

	@Column({
		type: "text",
		nullable: true
	})
	description: string;

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
