import { MigrationInterface, QueryRunner } from "typeorm";

export class UpdateTableDefinitionColumnCounts1788400000000 implements MigrationInterface {
    name = 'UpdateTableDefinitionColumnCounts1788400000000'

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`UPDATE "table_definition" SET "columnCount" = 10 WHERE "type" = 'hp'`);
        await queryRunner.query(`UPDATE "table_definition" SET "columnCount" = 10 WHERE "type" = 'evasionRate'`);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`UPDATE "table_definition" SET "columnCount" = 11 WHERE "type" = 'hp'`);
        await queryRunner.query(`UPDATE "table_definition" SET "columnCount" = 11 WHERE "type" = 'evasionRate'`);
    }

}
