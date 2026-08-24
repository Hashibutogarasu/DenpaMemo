import { readFile } from 'node:fs/promises';
import path from 'node:path';
import type { DataSource } from 'typeorm';
import { AttributeBonusEntity } from '../../entities/attribute-bonus.entity';
import { AttributeEntity } from '../../entities/attribute.entity';
import { HeadShapeEntity } from '../../entities/head-shape.entity';
import type { DuplicateIdGuard } from '../duplicate-id-guard';
import { listJsonFilesRecursively } from '../list-json-files';

interface HeadShapeJson {
  id: string;
  abnormalityResistanceBonuses?: Record<string, number>;
  attributeResistanceBonuses?: Record<string, number>;
  hpBonus?: number;
  apBonus?: number;
  attackBonus?: number;
  defenseBonus?: number;
  speedBonus?: number;
  evasionRateBonus?: number;
}

export async function loadHeadShapes(
  dataSource: DataSource,
  dataDir: string,
  guard: DuplicateIdGuard,
): Promise<void> {
  const headShapesDir = path.join(dataDir, 'head_shapes');
  const files = await listJsonFilesRecursively(headShapesDir);

  const attributeByLegacyId = new Map(
    (await dataSource.getRepository(AttributeEntity).find()).map((attribute) => [attribute.legacyId, attribute]),
  );

  await dataSource.transaction(async (manager) => {
    for (const file of files) {
      const json = JSON.parse(await readFile(file, 'utf-8')) as HeadShapeJson;
      guard.check('head_shape', json.id, path.relative(dataDir, file));

      const entity = new HeadShapeEntity();
      entity.legacyId = json.id;
      entity.abnormalityResistanceBonuses = json.abnormalityResistanceBonuses ?? {};
      entity.hpBonus = json.hpBonus ?? 0;
      entity.apBonus = json.apBonus ?? 0;
      entity.attackBonus = json.attackBonus ?? 0;
      entity.defenseBonus = json.defenseBonus ?? 0;
      entity.speedBonus = json.speedBonus ?? 0;
      entity.evasionRateBonus = json.evasionRateBonus ?? 0;
      await manager.save(entity);

      const bonuses = Object.entries(json.attributeResistanceBonuses ?? {}).map(([attributeId, bonus]) => {
        const attribute = attributeByLegacyId.get(attributeId);
        if (!attribute) {
          throw new Error(`Unknown attribute id "${attributeId}" in ${file}`);
        }
        const bonusEntity = new AttributeBonusEntity();
        bonusEntity.ownerType = 'head_shape';
        bonusEntity.ownerId = entity.id;
        bonusEntity.attribute = attribute;
        bonusEntity.bonus = bonus;
        return bonusEntity;
      });
      await manager.save(bonuses);
    }
  });
}
