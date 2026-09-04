import { MigrationInterface, QueryRunner } from 'typeorm';

export class AddPhysiqueEvasionRateCategory1788900000000 implements MigrationInterface {
  name = 'AddPhysiqueEvasionRateCategory1788900000000';

  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      `CREATE TABLE "physique_evasion_rate_category" ("id" character varying(24) NOT NULL, "evasionRateStart" integer NOT NULL, "evasionRateEnd" integer NOT NULL, "startColumn" integer NOT NULL, "columnOffset" integer NOT NULL, "textKey" character varying NOT NULL, "note" character varying, CONSTRAINT "PK_physique_evasion_rate_category_id" PRIMARY KEY ("id"))`,
    );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(`DROP TABLE "physique_evasion_rate_category"`);
  }
}
