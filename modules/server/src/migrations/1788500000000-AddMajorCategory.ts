import { MigrationInterface, QueryRunner } from "typeorm";

export class AddMajorCategory1788500000000 implements MigrationInterface {
    name = 'AddMajorCategory1788500000000'

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`CREATE TABLE "major_category" ("id" character varying NOT NULL, CONSTRAINT "PK_major_category_id" PRIMARY KEY ("id"))`);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`DROP TABLE "major_category"`);
    }

}
