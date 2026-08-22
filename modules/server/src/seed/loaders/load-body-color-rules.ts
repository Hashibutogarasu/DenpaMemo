import { readFile } from 'node:fs/promises';
import path from 'node:path';
import type { DataSource } from 'typeorm';
import { AttributeBonusEntity } from '../../entities/attribute-bonus.entity';
import { AttributeEntity } from '../../entities/attribute.entity';
import { BodyColorAbnormalityResistanceRuleEntity } from '../../entities/body-color-abnormality-resistance-rule.entity';
import { BodyColorResistanceRuleEntity } from '../../entities/body-color-resistance-rule.entity';
import type { DuplicateIdGuard } from '../duplicate-id-guard';

interface BodyColorAttributeResistanceJson {
  [colorId: string]: { attributeResistanceBonuses: Record<string, number> };
}

interface BodyColorAbnormalityResistanceJson {
  [colorId: string]: { abnormalityResistanceBonuses: Record<string, number> };
}

export async function loadBodyColorResistanceRules(
  dataSource: DataSource,
  dataDir: string,
  guard: DuplicateIdGuard,
): Promise<void> {
  const filePath = path.join(dataDir, 'body_color_attribute_resistance.json');
  const json = JSON.parse(await readFile(filePath, 'utf-8')) as BodyColorAttributeResistanceJson;

  const attributeByLegacyId = new Map(
    (await dataSource.getRepository(AttributeEntity).find()).map((attribute) => [attribute.legacyId, attribute]),
  );

  await dataSource.transaction(async (manager) => {
    for (const [colorId, value] of Object.entries(json)) {
      guard.check('body_color_resistance_rule', colorId, 'body_color_attribute_resistance.json');
      const rule = new BodyColorResistanceRuleEntity();
      rule.legacyId = colorId;
      await manager.save(rule);

      const bonuses = Object.entries(value.attributeResistanceBonuses).map(([attributeId, bonus]) => {
        const attribute = attributeByLegacyId.get(attributeId);
        if (!attribute) {
          throw new Error(`Unknown attribute id "${attributeId}" in body_color_attribute_resistance.json`);
        }
        const bonusEntity = new AttributeBonusEntity();
        bonusEntity.ownerType = 'body_color_resistance_rule';
        bonusEntity.ownerId = rule.id;
        bonusEntity.attribute = attribute;
        bonusEntity.bonus = bonus;
        return bonusEntity;
      });
      await manager.save(bonuses);
    }
  });
}

export async function loadBodyColorAbnormalityResistanceRules(
  dataSource: DataSource,
  dataDir: string,
  guard: DuplicateIdGuard,
): Promise<void> {
  const filePath = path.join(dataDir, 'body_color_abnormality_resistance.json');
  const json = JSON.parse(await readFile(filePath, 'utf-8')) as BodyColorAbnormalityResistanceJson;

  const entities = Object.entries(json).map(([colorId, value]) => {
    guard.check('body_color_abnormality_resistance_rule', colorId, 'body_color_abnormality_resistance.json');
    const entity = new BodyColorAbnormalityResistanceRuleEntity();
    entity.legacyId = colorId;
    entity.abnormalityResistanceBonuses = value.abnormalityResistanceBonuses;
    return entity;
  });

  await dataSource.getRepository(BodyColorAbnormalityResistanceRuleEntity).save(entities);
}
