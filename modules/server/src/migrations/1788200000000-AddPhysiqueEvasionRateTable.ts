import { MigrationInterface, QueryRunner } from "typeorm";

export class AddPhysiqueEvasionRateTable1788200000000 implements MigrationInterface {
    name = 'AddPhysiqueEvasionRateTable1788200000000'

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`CREATE TABLE "physique_evasion_rate_table" ("id" character varying(24) NOT NULL, "level" character varying NOT NULL, "anntenaCategory" character varying NOT NULL, "lineOffset" integer NOT NULL, "values" jsonb NOT NULL, CONSTRAINT "PK_physique_evasion_rate_table_id" PRIMARY KEY ("id"))`);
        await queryRunner.query(`CREATE UNIQUE INDEX "IDX_physique_evasion_rate_table_level_anntenaCategory_lineOffset" ON "physique_evasion_rate_table" ("level", "anntenaCategory", "lineOffset")`);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`DROP INDEX "IDX_physique_evasion_rate_table_level_anntenaCategory_lineOffset"`);
        await queryRunner.query(`DROP TABLE "physique_evasion_rate_table"`);
    }

}
