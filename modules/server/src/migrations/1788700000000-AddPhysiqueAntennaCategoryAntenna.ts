import { MigrationInterface, QueryRunner } from "typeorm";

export class AddPhysiqueAntennaCategoryAntenna1788700000000 implements MigrationInterface {
    name = 'AddPhysiqueAntennaCategoryAntenna1788700000000'

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`CREATE TABLE "physique_antenna_category_antenna" ("id" character varying(24) NOT NULL, "minorCategoryId" character varying NOT NULL, "anntenaId" character varying(24) NOT NULL, CONSTRAINT "PK_physique_antenna_category_antenna_id" PRIMARY KEY ("id"))`);
        await queryRunner.query(`CREATE UNIQUE INDEX "IDX_physique_antenna_category_antenna_minorCategoryId_anntenaId" ON "physique_antenna_category_antenna" ("minorCategoryId", "anntenaId")`);
        await queryRunner.query(`ALTER TABLE "physique_antenna_category_antenna" ADD CONSTRAINT "FK_physique_antenna_category_antenna_minorCategoryId" FOREIGN KEY ("minorCategoryId") REFERENCES "minor_category"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE "physique_antenna_category_antenna" ADD CONSTRAINT "FK_physique_antenna_category_antenna_anntenaId" FOREIGN KEY ("anntenaId") REFERENCES "anntena"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE "physique_antenna_category_antenna" DROP CONSTRAINT "FK_physique_antenna_category_antenna_anntenaId"`);
        await queryRunner.query(`ALTER TABLE "physique_antenna_category_antenna" DROP CONSTRAINT "FK_physique_antenna_category_antenna_minorCategoryId"`);
        await queryRunner.query(`DROP INDEX "IDX_physique_antenna_category_antenna_minorCategoryId_anntenaId"`);
        await queryRunner.query(`DROP TABLE "physique_antenna_category_antenna"`);
    }

}
