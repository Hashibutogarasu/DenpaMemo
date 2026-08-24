import { MigrationInterface, QueryRunner } from "typeorm";

export class AddMonsters1787561272755 implements MigrationInterface {
    name = 'AddMonsters1787561272755'

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`CREATE TABLE "monsters" ("id" character varying(24) NOT NULL, "translateKey" character varying NOT NULL, CONSTRAINT "UQ_monsters_translateKey" UNIQUE ("translateKey"), CONSTRAINT "PK_monsters_id" PRIMARY KEY ("id"))`);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`DROP TABLE "monsters"`);
    }

}
