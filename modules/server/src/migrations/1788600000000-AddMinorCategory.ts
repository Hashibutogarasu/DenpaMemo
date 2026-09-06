import { MigrationInterface, QueryRunner } from "typeorm";

export class AddMinorCategory1788600000000 implements MigrationInterface {
    name = 'AddMinorCategory1788600000000'

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`CREATE TABLE "minor_category" ("id" character varying NOT NULL, "majorCategoryId" character varying NOT NULL, "physiqueAntennaCategoryId" character varying(24) NOT NULL, CONSTRAINT "PK_minor_category_id" PRIMARY KEY ("id"))`);
        await queryRunner.query(`ALTER TABLE "minor_category" ADD CONSTRAINT "FK_minor_category_majorCategoryId" FOREIGN KEY ("majorCategoryId") REFERENCES "major_category"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE "minor_category" ADD CONSTRAINT "FK_minor_category_physiqueAntennaCategoryId" FOREIGN KEY ("physiqueAntennaCategoryId") REFERENCES "physique_antenna_category"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE "minor_category" DROP CONSTRAINT "FK_minor_category_physiqueAntennaCategoryId"`);
        await queryRunner.query(`ALTER TABLE "minor_category" DROP CONSTRAINT "FK_minor_category_majorCategoryId"`);
        await queryRunner.query(`DROP TABLE "minor_category"`);
    }

}
