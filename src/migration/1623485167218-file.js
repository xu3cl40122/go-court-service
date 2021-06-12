const { MigrationInterface, QueryRunner } = require("typeorm");

module.exports = class file1623485167218 {
    name = 'file1623485167218'

    async up(queryRunner) {
        await queryRunner.query(`ALTER TABLE "file" RENAME COLUMN "test_attr" TO "test2"`);
    }

    async down(queryRunner) {
        await queryRunner.query(`ALTER TABLE "file" RENAME COLUMN "test2" TO "test_attr"`);
    }
}
