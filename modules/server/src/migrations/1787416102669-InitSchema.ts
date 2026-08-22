import { MigrationInterface, QueryRunner } from "typeorm";

export class InitSchema1787416102669 implements MigrationInterface {
    name = 'InitSchema1787416102669'

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`CREATE TABLE "abnormality_type" ("id" character varying(24) NOT NULL, "legacyId" character varying NOT NULL, CONSTRAINT "UQ_11ce6c096c1f668039263686e71" UNIQUE ("legacyId"), CONSTRAINT "PK_45d43969d4704bcac3d95b17d0c" PRIMARY KEY ("id"))`);
        await queryRunner.query(`CREATE TABLE "antenna_category" ("code" smallint NOT NULL, "name" character varying NOT NULL, CONSTRAINT "UQ_a26ea9dff2aa4db220bb78c7ccf" UNIQUE ("name"), CONSTRAINT "PK_81a61054c33c3066aed37bd277a" PRIMARY KEY ("code"))`);
        await queryRunner.query(`CREATE TABLE "target_mode" ("code" smallint NOT NULL, "name" character varying NOT NULL, CONSTRAINT "UQ_295dc9b57d62a9ced6c1280d04d" UNIQUE ("name"), CONSTRAINT "PK_66cbb201383d86d2a9161a99e3b" PRIMARY KEY ("code"))`);
        await queryRunner.query(`CREATE TABLE "attribute_category" ("code" smallint NOT NULL, "name" character varying NOT NULL, CONSTRAINT "UQ_9233898f21928d13c5361199f8c" UNIQUE ("name"), CONSTRAINT "PK_98a8dc441704461879966b52f1f" PRIMARY KEY ("code"))`);
        await queryRunner.query(`CREATE TABLE "attribute" ("id" character varying(24) NOT NULL, "legacyId" character varying NOT NULL, "index" integer NOT NULL, "categoryId" smallint NOT NULL, CONSTRAINT "UQ_a2c72ba3efa8e94a211af82a761" UNIQUE ("legacyId"), CONSTRAINT "PK_b13fb7c5c9e9dff62b60e0de729" PRIMARY KEY ("id"))`);
        await queryRunner.query(`CREATE TABLE "anntena" ("id" character varying(24) NOT NULL, "legacyId" character varying NOT NULL, "categoryId" smallint NOT NULL, "targetCount" integer, "targetModeId" smallint, "dealsDamage" boolean NOT NULL DEFAULT false, "isInheritable" boolean NOT NULL DEFAULT false, "evolvesToId" character varying(24), "maxLevel" integer, "variantGroupId" character varying, "hasLevel" boolean NOT NULL DEFAULT true, CONSTRAINT "UQ_ca2f2605f198f38f103015aeb30" UNIQUE ("legacyId"), CONSTRAINT "PK_ab664de334f8b52dc8f267f94e6" PRIMARY KEY ("id"))`);
        await queryRunner.query(`CREATE TABLE "attribute_bonus" ("id" uuid NOT NULL DEFAULT uuid_generate_v4(), "ownerType" character varying NOT NULL, "ownerId" character varying(24) NOT NULL, "bonus" integer NOT NULL, "attributeId" character varying(24) NOT NULL, CONSTRAINT "PK_e99822c228327007c0fb41c714b" PRIMARY KEY ("id"))`);
        await queryRunner.query(`CREATE TABLE "body_color_abnormality_resistance_rule" ("id" character varying(24) NOT NULL, "legacyId" character varying NOT NULL, "abnormalityResistanceBonuses" jsonb NOT NULL DEFAULT '{}', CONSTRAINT "UQ_b930aac5fd6a33b570a9b857df4" UNIQUE ("legacyId"), CONSTRAINT "PK_cb25a7fd7cb2ab2b4e9833b0e9c" PRIMARY KEY ("id"))`);
        await queryRunner.query(`CREATE TABLE "body_color_resistance_rule" ("id" character varying(24) NOT NULL, "legacyId" character varying NOT NULL, CONSTRAINT "UQ_09ee26ad3d66b7118971a103e89" UNIQUE ("legacyId"), CONSTRAINT "PK_9b5a737ead1a7883e6180c3c02a" PRIMARY KEY ("id"))`);
        await queryRunner.query(`CREATE TABLE "correction" ("id" character varying(24) NOT NULL, "legacyId" character varying NOT NULL, "hpBonus" integer NOT NULL DEFAULT '0', "apBonus" integer NOT NULL DEFAULT '0', "attackBonus" integer NOT NULL DEFAULT '0', "defenseBonus" integer NOT NULL DEFAULT '0', "speedBonus" integer NOT NULL DEFAULT '0', "evasionRateBonus" integer NOT NULL DEFAULT '0', "abnormalityResistanceBonuses" jsonb NOT NULL DEFAULT '{}', CONSTRAINT "UQ_9db9f0cd957f4ae91513809fc76" UNIQUE ("legacyId"), CONSTRAINT "PK_87d78e856994ebac898b898ad9a" PRIMARY KEY ("id"))`);
        await queryRunner.query(`CREATE TABLE "head_shape" ("id" character varying(24) NOT NULL, "legacyId" character varying NOT NULL, "abnormalityResistanceBonuses" jsonb NOT NULL DEFAULT '{}', "hpBonus" integer NOT NULL DEFAULT '0', "apBonus" integer NOT NULL DEFAULT '0', "attackBonus" integer NOT NULL DEFAULT '0', "defenseBonus" integer NOT NULL DEFAULT '0', "speedBonus" integer NOT NULL DEFAULT '0', "evasionRateBonus" integer NOT NULL DEFAULT '0', CONSTRAINT "UQ_028b403993fc57b8de2f5c37f53" UNIQUE ("legacyId"), CONSTRAINT "PK_d4a805e5a00221d30826655df04" PRIMARY KEY ("id"))`);
        await queryRunner.query(`CREATE TABLE "pattern" ("id" character varying(24) NOT NULL, "legacyId" character varying NOT NULL, CONSTRAINT "UQ_58e0f3c565f314096dd19edad6f" UNIQUE ("legacyId"), CONSTRAINT "PK_50f41f421043f2637873957f277" PRIMARY KEY ("id"))`);
        await queryRunner.query(`CREATE TABLE "personality" ("id" character varying(24) NOT NULL, "legacyId" character varying NOT NULL, CONSTRAINT "UQ_32163bab20821bc4abdf23fc15d" UNIQUE ("legacyId"), CONSTRAINT "PK_97c40c392c5c1660fe601a376d1" PRIMARY KEY ("id"))`);
        await queryRunner.query(`CREATE TABLE "physique" ("id" character varying(24) NOT NULL, "legacyId" character varying NOT NULL, CONSTRAINT "UQ_9ca147fe01ccb1b0f47c6fef100" UNIQUE ("legacyId"), CONSTRAINT "PK_2ce9b802431dd81f25557d8bef2" PRIMARY KEY ("id"))`);
        await queryRunner.query(`CREATE TABLE "translation" ("id" uuid NOT NULL DEFAULT uuid_generate_v4(), "entityType" character varying NOT NULL, "entityLegacyId" character varying NOT NULL, "locale" character varying NOT NULL, "value" text NOT NULL, CONSTRAINT "PK_7aef875e43ab80d34a0cdd39c70" PRIMARY KEY ("id"))`);
        await queryRunner.query(`CREATE UNIQUE INDEX "IDX_cdf16642795c5ac3046d71f113" ON "translation" ("entityType", "entityLegacyId", "locale") `);
        await queryRunner.query(`CREATE TABLE "attribute_resistant_to" ("attributeId" character varying(24) NOT NULL, "resistantToId" character varying(24) NOT NULL, CONSTRAINT "PK_d3abcc41664519e9f99694d14b1" PRIMARY KEY ("attributeId", "resistantToId"))`);
        await queryRunner.query(`CREATE INDEX "IDX_47727cbbc548f41b33dcc98fd2" ON "attribute_resistant_to" ("attributeId") `);
        await queryRunner.query(`CREATE INDEX "IDX_54f793a6a104d07fa2b4d34915" ON "attribute_resistant_to" ("resistantToId") `);
        await queryRunner.query(`CREATE TABLE "attribute_weak_to" ("attributeId" character varying(24) NOT NULL, "weakToId" character varying(24) NOT NULL, CONSTRAINT "PK_5c178688e4c850b110072f7bcd4" PRIMARY KEY ("attributeId", "weakToId"))`);
        await queryRunner.query(`CREATE INDEX "IDX_545a986defb911e773f26040f1" ON "attribute_weak_to" ("attributeId") `);
        await queryRunner.query(`CREATE INDEX "IDX_e20b06fa62ba56ffb7e5e50d9a" ON "attribute_weak_to" ("weakToId") `);
        await queryRunner.query(`CREATE TABLE "anntena_attack_attribute" ("anntenaId" character varying(24) NOT NULL, "attributeId" character varying(24) NOT NULL, CONSTRAINT "PK_b410499674ee4a27a1fee4f0b5a" PRIMARY KEY ("anntenaId", "attributeId"))`);
        await queryRunner.query(`CREATE INDEX "IDX_69446e11896dff595a8134f46f" ON "anntena_attack_attribute" ("anntenaId") `);
        await queryRunner.query(`CREATE INDEX "IDX_f35b33b3daa90d77f1e95775df" ON "anntena_attack_attribute" ("attributeId") `);
        await queryRunner.query(`ALTER TABLE "attribute" ADD CONSTRAINT "FK_0addf3fdde9a4e133307fd1e9d6" FOREIGN KEY ("categoryId") REFERENCES "attribute_category"("code") ON DELETE NO ACTION ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE "anntena" ADD CONSTRAINT "FK_ab36181a0d1cc8d46f725e4bb8b" FOREIGN KEY ("categoryId") REFERENCES "antenna_category"("code") ON DELETE NO ACTION ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE "anntena" ADD CONSTRAINT "FK_549c61d118e2994d88efc2ed1c9" FOREIGN KEY ("targetModeId") REFERENCES "target_mode"("code") ON DELETE NO ACTION ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE "anntena" ADD CONSTRAINT "FK_daa60d1d523628a8887c2b34d74" FOREIGN KEY ("evolvesToId") REFERENCES "anntena"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE "attribute_bonus" ADD CONSTRAINT "FK_81bf98dc3fecf10e01f752134c4" FOREIGN KEY ("attributeId") REFERENCES "attribute"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE "attribute_resistant_to" ADD CONSTRAINT "FK_47727cbbc548f41b33dcc98fd28" FOREIGN KEY ("attributeId") REFERENCES "attribute"("id") ON DELETE CASCADE ON UPDATE CASCADE`);
        await queryRunner.query(`ALTER TABLE "attribute_resistant_to" ADD CONSTRAINT "FK_54f793a6a104d07fa2b4d34915a" FOREIGN KEY ("resistantToId") REFERENCES "attribute"("id") ON DELETE CASCADE ON UPDATE CASCADE`);
        await queryRunner.query(`ALTER TABLE "attribute_weak_to" ADD CONSTRAINT "FK_545a986defb911e773f26040f15" FOREIGN KEY ("attributeId") REFERENCES "attribute"("id") ON DELETE CASCADE ON UPDATE CASCADE`);
        await queryRunner.query(`ALTER TABLE "attribute_weak_to" ADD CONSTRAINT "FK_e20b06fa62ba56ffb7e5e50d9af" FOREIGN KEY ("weakToId") REFERENCES "attribute"("id") ON DELETE CASCADE ON UPDATE CASCADE`);
        await queryRunner.query(`ALTER TABLE "anntena_attack_attribute" ADD CONSTRAINT "FK_69446e11896dff595a8134f46fe" FOREIGN KEY ("anntenaId") REFERENCES "anntena"("id") ON DELETE CASCADE ON UPDATE CASCADE`);
        await queryRunner.query(`ALTER TABLE "anntena_attack_attribute" ADD CONSTRAINT "FK_f35b33b3daa90d77f1e95775df3" FOREIGN KEY ("attributeId") REFERENCES "attribute"("id") ON DELETE CASCADE ON UPDATE CASCADE`);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE "anntena_attack_attribute" DROP CONSTRAINT "FK_f35b33b3daa90d77f1e95775df3"`);
        await queryRunner.query(`ALTER TABLE "anntena_attack_attribute" DROP CONSTRAINT "FK_69446e11896dff595a8134f46fe"`);
        await queryRunner.query(`ALTER TABLE "attribute_weak_to" DROP CONSTRAINT "FK_e20b06fa62ba56ffb7e5e50d9af"`);
        await queryRunner.query(`ALTER TABLE "attribute_weak_to" DROP CONSTRAINT "FK_545a986defb911e773f26040f15"`);
        await queryRunner.query(`ALTER TABLE "attribute_resistant_to" DROP CONSTRAINT "FK_54f793a6a104d07fa2b4d34915a"`);
        await queryRunner.query(`ALTER TABLE "attribute_resistant_to" DROP CONSTRAINT "FK_47727cbbc548f41b33dcc98fd28"`);
        await queryRunner.query(`ALTER TABLE "attribute_bonus" DROP CONSTRAINT "FK_81bf98dc3fecf10e01f752134c4"`);
        await queryRunner.query(`ALTER TABLE "anntena" DROP CONSTRAINT "FK_daa60d1d523628a8887c2b34d74"`);
        await queryRunner.query(`ALTER TABLE "anntena" DROP CONSTRAINT "FK_549c61d118e2994d88efc2ed1c9"`);
        await queryRunner.query(`ALTER TABLE "anntena" DROP CONSTRAINT "FK_ab36181a0d1cc8d46f725e4bb8b"`);
        await queryRunner.query(`ALTER TABLE "attribute" DROP CONSTRAINT "FK_0addf3fdde9a4e133307fd1e9d6"`);
        await queryRunner.query(`DROP INDEX "public"."IDX_f35b33b3daa90d77f1e95775df"`);
        await queryRunner.query(`DROP INDEX "public"."IDX_69446e11896dff595a8134f46f"`);
        await queryRunner.query(`DROP TABLE "anntena_attack_attribute"`);
        await queryRunner.query(`DROP INDEX "public"."IDX_e20b06fa62ba56ffb7e5e50d9a"`);
        await queryRunner.query(`DROP INDEX "public"."IDX_545a986defb911e773f26040f1"`);
        await queryRunner.query(`DROP TABLE "attribute_weak_to"`);
        await queryRunner.query(`DROP INDEX "public"."IDX_54f793a6a104d07fa2b4d34915"`);
        await queryRunner.query(`DROP INDEX "public"."IDX_47727cbbc548f41b33dcc98fd2"`);
        await queryRunner.query(`DROP TABLE "attribute_resistant_to"`);
        await queryRunner.query(`DROP INDEX "public"."IDX_cdf16642795c5ac3046d71f113"`);
        await queryRunner.query(`DROP TABLE "translation"`);
        await queryRunner.query(`DROP TABLE "physique"`);
        await queryRunner.query(`DROP TABLE "personality"`);
        await queryRunner.query(`DROP TABLE "pattern"`);
        await queryRunner.query(`DROP TABLE "head_shape"`);
        await queryRunner.query(`DROP TABLE "correction"`);
        await queryRunner.query(`DROP TABLE "body_color_resistance_rule"`);
        await queryRunner.query(`DROP TABLE "body_color_abnormality_resistance_rule"`);
        await queryRunner.query(`DROP TABLE "attribute_bonus"`);
        await queryRunner.query(`DROP TABLE "anntena"`);
        await queryRunner.query(`DROP TABLE "attribute"`);
        await queryRunner.query(`DROP TABLE "attribute_category"`);
        await queryRunner.query(`DROP TABLE "target_mode"`);
        await queryRunner.query(`DROP TABLE "antenna_category"`);
        await queryRunner.query(`DROP TABLE "abnormality_type"`);
    }

}
