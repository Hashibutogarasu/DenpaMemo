import { MigrationInterface, QueryRunner } from "typeorm";

export class AddPhysiqueTable1788000000000 implements MigrationInterface {
    name = 'AddPhysiqueTable1788000000000'

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`CREATE TABLE "physique_antenna_category" ("id" character varying(24) NOT NULL, "category" character varying NOT NULL, "anntenaCategory" character varying NOT NULL, CONSTRAINT "UQ_physique_antenna_category_anntenaCategory" UNIQUE ("anntenaCategory"), CONSTRAINT "PK_physique_antenna_category_id" PRIMARY KEY ("id"))`);
        await queryRunner.query(`CREATE TABLE "physique_table" ("id" character varying(24) NOT NULL, "level" character varying NOT NULL, "anntenaCategory" character varying NOT NULL, "lineOffset" integer NOT NULL, "values" jsonb NOT NULL, CONSTRAINT "PK_physique_table_id" PRIMARY KEY ("id"))`);
        await queryRunner.query(`CREATE UNIQUE INDEX "IDX_physique_table_level_anntenaCategory_lineOffset" ON "physique_table" ("level", "anntenaCategory", "lineOffset")`);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`DROP INDEX "IDX_physique_table_level_anntenaCategory_lineOffset"`);
        await queryRunner.query(`DROP TABLE "physique_table"`);
        await queryRunner.query(`DROP TABLE "physique_antenna_category"`);
    }

}
