const { MigrationInterface, QueryRunner } = require("typeorm");

module.exports = class file1623485279974 {
    name = 'file1623485279974'

    async up(queryRunner) {
        await queryRunner.query(`ALTER TABLE "file" DROP COLUMN "test2"`);
    }

    async down(queryRunner) {
        await queryRunner.query(`ALTER TABLE "file" ADD "test2" text`);
    }
}
