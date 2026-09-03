import { MigrationInterface, QueryRunner } from "typeorm";

export class AddTableDefinition1788300000000 implements MigrationInterface {
    name = 'AddTableDefinition1788300000000'

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`CREATE TABLE "table_definition" ("id" character varying(24) NOT NULL, "type" character varying NOT NULL, "columnCount" integer NOT NULL, "translationKey" character varying NOT NULL, CONSTRAINT "UQ_table_definition_type" UNIQUE ("type"), CONSTRAINT "PK_table_definition_id" PRIMARY KEY ("id"))`);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`DROP TABLE "table_definition"`);
    }

}
