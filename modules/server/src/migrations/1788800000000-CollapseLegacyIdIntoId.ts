import { MigrationInterface, QueryRunner } from 'typeorm';

/**
 * Collapses every `BaseEntity`-derived table's redundant `id`
 * (internally generated cuid2) and `legacyId` (the semantic id from
 * the master-data JSON) into a single `id` column carrying the
 * semantic value. Every foreign key/pivot column referencing one of
 * these tables' old `id` is remapped to the corresponding `legacyId`
 * value before the columns are dropped/renamed.
 *
 * This is a one-way data migration: the old generated cuid values are
 * not recoverable, so `down()` only restores the previous column
 * shape (`id` + `legacyId`) by re-deriving a placeholder `id`; any code
 * or data that depended on the specific old cuid values is not
 * restored.
 */
export class CollapseLegacyIdIntoId1788800000000 implements MigrationInterface {
  name = 'CollapseLegacyIdIntoId1788800000000';

  private readonly tables = [
    { table: 'abnormality_type', uq: 'UQ_11ce6c096c1f668039263686e71', pk: 'PK_45d43969d4704bcac3d95b17d0c' },
    { table: 'attribute', uq: 'UQ_a2c72ba3efa8e94a211af82a761', pk: 'PK_b13fb7c5c9e9dff62b60e0de729' },
    { table: 'anntena', uq: 'UQ_ca2f2605f198f38f103015aeb30', pk: 'PK_ab664de334f8b52dc8f267f94e6' },
    {
      table: 'body_color_abnormality_resistance_rule',
      uq: 'UQ_b930aac5fd6a33b570a9b857df4',
      pk: 'PK_cb25a7fd7cb2ab2b4e9833b0e9c',
    },
    { table: 'body_color_resistance_rule', uq: 'UQ_09ee26ad3d66b7118971a103e89', pk: 'PK_9b5a737ead1a7883e6180c3c02a' },
    { table: 'correction', uq: 'UQ_9db9f0cd957f4ae91513809fc76', pk: 'PK_87d78e856994ebac898b898ad9a' },
    { table: 'head_shape', uq: 'UQ_028b403993fc57b8de2f5c37f53', pk: 'PK_d4a805e5a00221d30826655df04' },
    { table: 'pattern', uq: 'UQ_58e0f3c565f314096dd19edad6f', pk: 'PK_50f41f421043f2637873957f277' },
    { table: 'personality', uq: 'UQ_32163bab20821bc4abdf23fc15d', pk: 'PK_97c40c392c5c1660fe601a376d1' },
    { table: 'physique', uq: 'UQ_9ca147fe01ccb1b0f47c6fef100', pk: 'PK_2ce9b802431dd81f25557d8bef2' },
  ];

  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(`ALTER TABLE "anntena" DROP CONSTRAINT "FK_daa60d1d523628a8887c2b34d74"`);
    await queryRunner.query(`ALTER TABLE "attribute_bonus" DROP CONSTRAINT "FK_81bf98dc3fecf10e01f752134c4"`);
    await queryRunner.query(`ALTER TABLE "attribute_resistant_to" DROP CONSTRAINT "FK_47727cbbc548f41b33dcc98fd28"`);
    await queryRunner.query(`ALTER TABLE "attribute_resistant_to" DROP CONSTRAINT "FK_54f793a6a104d07fa2b4d34915a"`);
    await queryRunner.query(`ALTER TABLE "attribute_weak_to" DROP CONSTRAINT "FK_545a986defb911e773f26040f15"`);
    await queryRunner.query(`ALTER TABLE "attribute_weak_to" DROP CONSTRAINT "FK_e20b06fa62ba56ffb7e5e50d9af"`);
    await queryRunner.query(`ALTER TABLE "anntena_attack_attribute" DROP CONSTRAINT "FK_69446e11896dff595a8134f46fe"`);
    await queryRunner.query(`ALTER TABLE "anntena_attack_attribute" DROP CONSTRAINT "FK_f35b33b3daa90d77f1e95775df3"`);
    await queryRunner.query(
      `ALTER TABLE "physique_antenna_category_antenna" DROP CONSTRAINT "FK_physique_antenna_category_antenna_anntenaId"`,
    );

    await queryRunner.query(
      `UPDATE "anntena" AS self SET "evolvesToId" = target."legacyId" FROM "anntena" AS target WHERE self."evolvesToId" = target."id"`,
    );
    await queryRunner.query(
      `UPDATE "attribute_bonus" SET "attributeId" = target."legacyId" FROM "attribute" AS target WHERE "attribute_bonus"."attributeId" = target."id"`,
    );
    await queryRunner.query(
      `UPDATE "attribute_bonus" SET "ownerId" = target."legacyId" FROM "head_shape" AS target WHERE "attribute_bonus"."ownerType" = 'head_shape' AND "attribute_bonus"."ownerId" = target."id"`,
    );
    await queryRunner.query(
      `UPDATE "attribute_bonus" SET "ownerId" = target."legacyId" FROM "body_color_resistance_rule" AS target WHERE "attribute_bonus"."ownerType" = 'body_color_resistance_rule' AND "attribute_bonus"."ownerId" = target."id"`,
    );
    await queryRunner.query(
      `UPDATE "attribute_resistant_to" SET "attributeId" = target."legacyId" FROM "attribute" AS target WHERE "attribute_resistant_to"."attributeId" = target."id"`,
    );
    await queryRunner.query(
      `UPDATE "attribute_resistant_to" SET "resistantToId" = target."legacyId" FROM "attribute" AS target WHERE "attribute_resistant_to"."resistantToId" = target."id"`,
    );
    await queryRunner.query(
      `UPDATE "attribute_weak_to" SET "attributeId" = target."legacyId" FROM "attribute" AS target WHERE "attribute_weak_to"."attributeId" = target."id"`,
    );
    await queryRunner.query(
      `UPDATE "attribute_weak_to" SET "weakToId" = target."legacyId" FROM "attribute" AS target WHERE "attribute_weak_to"."weakToId" = target."id"`,
    );
    await queryRunner.query(
      `UPDATE "anntena_attack_attribute" SET "anntenaId" = target."legacyId" FROM "anntena" AS target WHERE "anntena_attack_attribute"."anntenaId" = target."id"`,
    );
    await queryRunner.query(
      `UPDATE "anntena_attack_attribute" SET "attributeId" = target."legacyId" FROM "attribute" AS target WHERE "anntena_attack_attribute"."attributeId" = target."id"`,
    );
    await queryRunner.query(
      `UPDATE "physique_antenna_category_antenna" SET "anntenaId" = target."legacyId" FROM "anntena" AS target WHERE "physique_antenna_category_antenna"."anntenaId" = target."id"`,
    );

    for (const { table, uq, pk } of this.tables) {
      await queryRunner.query(`ALTER TABLE "${table}" DROP CONSTRAINT "${uq}"`);
      await queryRunner.query(`ALTER TABLE "${table}" DROP CONSTRAINT "${pk}"`);
      await queryRunner.query(`ALTER TABLE "${table}" DROP COLUMN "id"`);
      await queryRunner.query(`ALTER TABLE "${table}" RENAME COLUMN "legacyId" TO "id"`);
      await queryRunner.query(`ALTER TABLE "${table}" ADD CONSTRAINT "${pk}" PRIMARY KEY ("id")`);
    }

    await queryRunner.query(
      `ALTER TABLE "anntena" ADD CONSTRAINT "FK_daa60d1d523628a8887c2b34d74" FOREIGN KEY ("evolvesToId") REFERENCES "anntena"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`,
    );
    await queryRunner.query(
      `ALTER TABLE "attribute_bonus" ADD CONSTRAINT "FK_81bf98dc3fecf10e01f752134c4" FOREIGN KEY ("attributeId") REFERENCES "attribute"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`,
    );
    await queryRunner.query(
      `ALTER TABLE "attribute_resistant_to" ADD CONSTRAINT "FK_47727cbbc548f41b33dcc98fd28" FOREIGN KEY ("attributeId") REFERENCES "attribute"("id") ON DELETE CASCADE ON UPDATE CASCADE`,
    );
    await queryRunner.query(
      `ALTER TABLE "attribute_resistant_to" ADD CONSTRAINT "FK_54f793a6a104d07fa2b4d34915a" FOREIGN KEY ("resistantToId") REFERENCES "attribute"("id") ON DELETE CASCADE ON UPDATE CASCADE`,
    );
    await queryRunner.query(
      `ALTER TABLE "attribute_weak_to" ADD CONSTRAINT "FK_545a986defb911e773f26040f15" FOREIGN KEY ("attributeId") REFERENCES "attribute"("id") ON DELETE CASCADE ON UPDATE CASCADE`,
    );
    await queryRunner.query(
      `ALTER TABLE "attribute_weak_to" ADD CONSTRAINT "FK_e20b06fa62ba56ffb7e5e50d9af" FOREIGN KEY ("weakToId") REFERENCES "attribute"("id") ON DELETE CASCADE ON UPDATE CASCADE`,
    );
    await queryRunner.query(
      `ALTER TABLE "anntena_attack_attribute" ADD CONSTRAINT "FK_69446e11896dff595a8134f46fe" FOREIGN KEY ("anntenaId") REFERENCES "anntena"("id") ON DELETE CASCADE ON UPDATE CASCADE`,
    );
    await queryRunner.query(
      `ALTER TABLE "anntena_attack_attribute" ADD CONSTRAINT "FK_f35b33b3daa90d77f1e95775df3" FOREIGN KEY ("attributeId") REFERENCES "attribute"("id") ON DELETE CASCADE ON UPDATE CASCADE`,
    );
    await queryRunner.query(
      `ALTER TABLE "physique_antenna_category_antenna" ADD CONSTRAINT "FK_physique_antenna_category_antenna_anntenaId" FOREIGN KEY ("anntenaId") REFERENCES "anntena"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`,
    );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(`ALTER TABLE "anntena" DROP CONSTRAINT "FK_daa60d1d523628a8887c2b34d74"`);
    await queryRunner.query(`ALTER TABLE "attribute_bonus" DROP CONSTRAINT "FK_81bf98dc3fecf10e01f752134c4"`);
    await queryRunner.query(`ALTER TABLE "attribute_resistant_to" DROP CONSTRAINT "FK_47727cbbc548f41b33dcc98fd28"`);
    await queryRunner.query(`ALTER TABLE "attribute_resistant_to" DROP CONSTRAINT "FK_54f793a6a104d07fa2b4d34915a"`);
    await queryRunner.query(`ALTER TABLE "attribute_weak_to" DROP CONSTRAINT "FK_545a986defb911e773f26040f15"`);
    await queryRunner.query(`ALTER TABLE "attribute_weak_to" DROP CONSTRAINT "FK_e20b06fa62ba56ffb7e5e50d9af"`);
    await queryRunner.query(`ALTER TABLE "anntena_attack_attribute" DROP CONSTRAINT "FK_69446e11896dff595a8134f46fe"`);
    await queryRunner.query(`ALTER TABLE "anntena_attack_attribute" DROP CONSTRAINT "FK_f35b33b3daa90d77f1e95775df3"`);
    await queryRunner.query(
      `ALTER TABLE "physique_antenna_category_antenna" DROP CONSTRAINT "FK_physique_antenna_category_antenna_anntenaId"`,
    );

    for (const { table, uq, pk } of this.tables) {
      await queryRunner.query(`ALTER TABLE "${table}" DROP CONSTRAINT "${pk}"`);
      await queryRunner.query(`ALTER TABLE "${table}" RENAME COLUMN "id" TO "legacyId"`);
      await queryRunner.query(`ALTER TABLE "${table}" ADD COLUMN "id" character varying(24)`);
      await queryRunner.query(`UPDATE "${table}" SET "id" = "legacyId"`);
      await queryRunner.query(`ALTER TABLE "${table}" ALTER COLUMN "id" SET NOT NULL`);
      await queryRunner.query(`ALTER TABLE "${table}" ADD CONSTRAINT "${pk}" PRIMARY KEY ("id")`);
      await queryRunner.query(`ALTER TABLE "${table}" ADD CONSTRAINT "${uq}" UNIQUE ("legacyId")`);
    }

    await queryRunner.query(
      `ALTER TABLE "physique_antenna_category_antenna" ADD CONSTRAINT "FK_physique_antenna_category_antenna_anntenaId" FOREIGN KEY ("anntenaId") REFERENCES "anntena"("legacyId") ON DELETE NO ACTION ON UPDATE NO ACTION`,
    );
    await queryRunner.query(
      `ALTER TABLE "anntena_attack_attribute" ADD CONSTRAINT "FK_f35b33b3daa90d77f1e95775df3" FOREIGN KEY ("attributeId") REFERENCES "attribute"("legacyId") ON DELETE CASCADE ON UPDATE CASCADE`,
    );
    await queryRunner.query(
      `ALTER TABLE "anntena_attack_attribute" ADD CONSTRAINT "FK_69446e11896dff595a8134f46fe" FOREIGN KEY ("anntenaId") REFERENCES "anntena"("legacyId") ON DELETE CASCADE ON UPDATE CASCADE`,
    );
    await queryRunner.query(
      `ALTER TABLE "attribute_weak_to" ADD CONSTRAINT "FK_e20b06fa62ba56ffb7e5e50d9af" FOREIGN KEY ("weakToId") REFERENCES "attribute"("legacyId") ON DELETE CASCADE ON UPDATE CASCADE`,
    );
    await queryRunner.query(
      `ALTER TABLE "attribute_weak_to" ADD CONSTRAINT "FK_545a986defb911e773f26040f15" FOREIGN KEY ("attributeId") REFERENCES "attribute"("legacyId") ON DELETE CASCADE ON UPDATE CASCADE`,
    );
    await queryRunner.query(
      `ALTER TABLE "attribute_resistant_to" ADD CONSTRAINT "FK_54f793a6a104d07fa2b4d34915a" FOREIGN KEY ("resistantToId") REFERENCES "attribute"("legacyId") ON DELETE CASCADE ON UPDATE CASCADE`,
    );
    await queryRunner.query(
      `ALTER TABLE "attribute_resistant_to" ADD CONSTRAINT "FK_47727cbbc548f41b33dcc98fd28" FOREIGN KEY ("attributeId") REFERENCES "attribute"("legacyId") ON DELETE CASCADE ON UPDATE CASCADE`,
    );
    await queryRunner.query(
      `ALTER TABLE "attribute_bonus" ADD CONSTRAINT "FK_81bf98dc3fecf10e01f752134c4" FOREIGN KEY ("attributeId") REFERENCES "attribute"("legacyId") ON DELETE NO ACTION ON UPDATE NO ACTION`,
    );
    await queryRunner.query(
      `ALTER TABLE "anntena" ADD CONSTRAINT "FK_daa60d1d523628a8887c2b34d74" FOREIGN KEY ("evolvesToId") REFERENCES "anntena"("legacyId") ON DELETE NO ACTION ON UPDATE NO ACTION`,
    );
  }
}
