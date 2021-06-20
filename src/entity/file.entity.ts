import { Entity, PrimaryGeneratedColumn, CreateDateColumn, UpdateDateColumn, Column } from "typeorm";
import { ApiProperty } from '@nestjs/swagger'

@Entity()
export class File {

	@PrimaryGeneratedColumn("uuid")
	@ApiProperty()
	file_id: string;

	@Column({
		type: "varchar",
		length: 150,
	})
	@ApiProperty()
	file_name: string;

	@Column({
		type: "varchar",
		length: 150,
		nullable: true
	})
	@ApiProperty()
	tag: string;

	@Column({
		type: "varchar",
		length: 300,
		nullable: true
	})
	@ApiProperty()
	file_url: string;

	@Column({
		type: "varchar",
		length: 300,
	})
	@ApiProperty()
	created_by: string;

	@Column({
		type: "varchar",
		length: 300,
	})
	@ApiProperty()
	reference_id: string;

	@Column({
		type: "boolean",
		default: true
	})
	@ApiProperty()
	is_public: boolean;

	@Column({
		type: "text",
		nullable: true
	})
	@ApiProperty()
	description: string;

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
