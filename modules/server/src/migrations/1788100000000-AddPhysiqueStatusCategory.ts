import { MigrationInterface, QueryRunner } from "typeorm";

export class AddPhysiqueStatusCategory1788100000000 implements MigrationInterface {
    name = 'AddPhysiqueStatusCategory1788100000000'

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`CREATE TABLE "physique_status_category" ("id" character varying(24) NOT NULL, "name" character varying NOT NULL, "columnCount" integer NOT NULL, CONSTRAINT "UQ_physique_status_category_name" UNIQUE ("name"), CONSTRAINT "PK_physique_status_category_id" PRIMARY KEY ("id"))`);
        await queryRunner.query(`ALTER TABLE "physique_table" ADD "statusCategory" character varying NOT NULL DEFAULT 'HP'`);
        await queryRunner.query(`DROP INDEX "IDX_physique_table_level_anntenaCategory_lineOffset"`);
        await queryRunner.query(`CREATE UNIQUE INDEX "IDX_physique_table_statusCategory_level_anntenaCategory_lineOffset" ON "physique_table" ("statusCategory", "level", "anntenaCategory", "lineOffset")`);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`DROP INDEX "IDX_physique_table_statusCategory_level_anntenaCategory_lineOffset"`);
        await queryRunner.query(`CREATE UNIQUE INDEX "IDX_physique_table_level_anntenaCategory_lineOffset" ON "physique_table" ("level", "anntenaCategory", "lineOffset")`);
        await queryRunner.query(`ALTER TABLE "physique_table" DROP COLUMN "statusCategory"`);
        await queryRunner.query(`DROP TABLE "physique_status_category"`);
    }

}
