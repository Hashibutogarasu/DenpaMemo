import type { DataSource } from 'typeorm';
import { AbnormalityTypeEntity } from '../../entities/abnormality-type.entity';
import { AnntenaEntity } from '../../entities/anntena.entity';
import { AttributeEntity } from '../../entities/attribute.entity';
import { AttributeBonusEntity, type AttributeBonusOwnerType } from '../../entities/attribute-bonus.entity';
import { BodyColorAbnormalityResistanceRuleEntity } from '../../entities/body-color-abnormality-resistance-rule.entity';
import { BodyColorResistanceRuleEntity } from '../../entities/body-color-resistance-rule.entity';
import { CorrectionEntity } from '../../entities/correction.entity';
import { HeadShapeEntity } from '../../entities/head-shape.entity';
import { PatternEntity } from '../../entities/pattern.entity';
import { PersonalityEntity } from '../../entities/personality.entity';
import { PhysiqueAntennaCategoryEntity } from '../../entities/physique-antenna-category.entity';
import { PhysiqueEntity } from '../../entities/physique.entity';

async function attributeResistanceBonusesFor(dataSource: DataSource, ownerType: AttributeBonusOwnerType, ownerId: string) {
  const bonuses = await dataSource.getRepository(AttributeBonusEntity).find({ where: { ownerType, ownerId } });
  return bonuses.map((bonus) => ({ attribute: bonus.attribute, bonus: bonus.bonus }));
}

export async function resolveMasterData(dataSource: DataSource) {
  const headShapeRepo = dataSource.getRepository(HeadShapeEntity);
  const anntenaRepo = dataSource.getRepository(AnntenaEntity);
  const attributeRepo = dataSource.getRepository(AttributeEntity);
  const bodyColorResistanceRuleRepo = dataSource.getRepository(BodyColorResistanceRuleEntity);

  const [
    headShapes,
    anntenas,
    attributes,
    abnormalityTypes,
    bodyColorResistanceRules,
    bodyColorAbnormalityResistanceRules,
    physiques,
    personalities,
    patterns,
    corrections,
    physiqueAntennaCategories,
  ] = await Promise.all([
    headShapeRepo.find(),
    anntenaRepo.find(),
    attributeRepo.find({ relations: { resistantTo: true, weakTo: true } }),
    dataSource.getRepository(AbnormalityTypeEntity).find(),
    bodyColorResistanceRuleRepo.find(),
    dataSource.getRepository(BodyColorAbnormalityResistanceRuleEntity).find(),
    dataSource.getRepository(PhysiqueEntity).find(),
    dataSource.getRepository(PersonalityEntity).find(),
    dataSource.getRepository(PatternEntity).find(),
    dataSource.getRepository(CorrectionEntity).find(),
    dataSource.getRepository(PhysiqueAntennaCategoryEntity).find(),
  ]);

  const anntenaLegacyIdById = new Map(anntenas.map((anntena) => [anntena.id, anntena.legacyId]));

  return {
    headShapes: await Promise.all(
      headShapes.map(async (headShape) => ({
        ...headShape,
        attributeResistanceBonuses: await attributeResistanceBonusesFor(dataSource, 'head_shape', headShape.id),
      })),
    ),
    anntenas: anntenas.map((anntena) => ({
      ...anntena,
      evolvesToId: anntena.evolvesToId ? (anntenaLegacyIdById.get(anntena.evolvesToId) ?? null) : null,
    })),
    attributes,
    abnormalityTypes,
    bodyColorResistanceRules: await Promise.all(
      bodyColorResistanceRules.map(async (rule) => ({
        ...rule,
        attributeResistanceBonuses: await attributeResistanceBonusesFor(
          dataSource,
          'body_color_resistance_rule',
          rule.id,
        ),
      })),
    ),
    bodyColorAbnormalityResistanceRules,
    physiques,
    personalities,
    patterns,
    corrections,
    physiqueAntennaCategories,
    physiqueTableColumnCount: 11,
  };
}
