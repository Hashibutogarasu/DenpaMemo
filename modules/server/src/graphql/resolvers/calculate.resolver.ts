import type { DataSource } from 'typeorm';
import { AttributeBonusEntity } from '../../entities/attribute-bonus.entity';
import { AttributeEntity } from '../../entities/attribute.entity';
import { AttributeCategoryEntity } from '../../entities/attribute-category.entity';
import { BodyColorAbnormalityResistanceRuleEntity } from '../../entities/body-color-abnormality-resistance-rule.entity';
import { BodyColorResistanceRuleEntity } from '../../entities/body-color-resistance-rule.entity';
import { calculateDenpaMenResistances } from '../../domain/resistance/denpa-men-resistance-calculator';
import type { ResistanceMasterData } from '../../domain/resistance/types';

interface CalculateResistancesArgs {
  input: {
    bodyColors: string[];
    isSpColor: boolean;
    headShape: {
      abnormalityResistanceBonuses: Record<string, number>;
      attributeResistanceBonuses: Array<{ attributeId: string; bonus: number }>;
    };
  };
}

async function buildResistanceMasterData(dataSource: DataSource): Promise<ResistanceMasterData> {
  const attributeCategoryByCode = new Map(
    (await dataSource.getRepository(AttributeCategoryEntity).find()).map((category) => [category.code, category.name]),
  );
  const attributes = (await dataSource.getRepository(AttributeEntity).find()).map((attribute) => ({
    id: attribute.legacyId,
    index: attribute.index,
    category: (attributeCategoryByCode.get(attribute.categoryId) ?? 'special') as 'elemental' | 'special',
  }));

  const bodyColorResistanceRuleEntities = await dataSource.getRepository(BodyColorResistanceRuleEntity).find();
  const bonusRepo = dataSource.getRepository(AttributeBonusEntity);
  const bodyColorResistanceRules = await Promise.all(
    bodyColorResistanceRuleEntities.map(async (rule) => {
      const bonuses = await bonusRepo.find({
        where: { ownerType: 'body_color_resistance_rule', ownerId: rule.id },
      });
      return {
        colorId: rule.legacyId,
        attributeResistanceBonuses: bonuses.map((bonus) => ({
          attributeId: bonus.attribute.legacyId,
          bonus: bonus.bonus,
        })),
      };
    }),
  );

  const bodyColorAbnormalityResistanceRules = (
    await dataSource.getRepository(BodyColorAbnormalityResistanceRuleEntity).find()
  ).map((rule) => ({
    colorId: rule.legacyId,
    abnormalityResistanceBonuses: rule.abnormalityResistanceBonuses,
  }));

  return { attributes, bodyColorResistanceRules, bodyColorAbnormalityResistanceRules };
}

export async function resolveCalculateResistances(dataSource: DataSource, args: CalculateResistancesArgs) {
  const masterData = await buildResistanceMasterData(dataSource);
  return calculateDenpaMenResistances(
    { bodyColors: args.input.bodyColors, isSpColor: args.input.isSpColor },
    args.input.headShape,
    masterData,
  );
}
