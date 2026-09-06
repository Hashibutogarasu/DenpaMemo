import { readFile } from 'node:fs/promises';
import path from 'node:path';
import type { DataSource } from 'typeorm';
import { AnntenaEntity } from '../../entities/anntena.entity';
import { AttributeEntity } from '../../entities/attribute.entity';
import type { DuplicateIdGuard } from '../duplicate-id-guard';
import { listJsonFilesRecursively } from '../list-json-files';

interface AntennaJson {
  id: string;
  category: 'attack' | 'support' | 'other';
  targetCount?: number | null;
  targetsAll?: boolean;
  dealsDamage?: boolean;
  attackAttributeIds?: string[];
  isInheritable?: boolean;
  evolvesToId?: string | null;
  maxLevel?: number | null;
  variantGroupId?: string | null;
  hasLevel?: boolean;
}

const CATEGORY_IDS: Record<AntennaJson['category'], number> = {
  attack: 0,
  support: 1,
  other: 2,
};

function deriveTargetModeId(row: AntennaJson): number | null {
  if (row.targetsAll === true) return 1;
  if (row.id.includes('_solo_')) return 0;
  return null;
}

export async function loadAntennas(
  dataSource: DataSource,
  dataDir: string,
  guard: DuplicateIdGuard,
): Promise<void> {
  const attributeById = new Map(
    (await dataSource.getRepository(AttributeEntity).find()).map((attribute) => [attribute.id, attribute]),
  );

  const antennasDir = path.join(dataDir, 'antennas');
  const files = await listJsonFilesRecursively(antennasDir);

  const parsedRows: AntennaJson[] = [];
  for (const file of files) {
    const source = path.relative(dataDir, file);
    const rows = JSON.parse(await readFile(file, 'utf-8')) as AntennaJson[];
    for (const row of rows) {
      guard.check('anntena', row.id, source);
      parsedRows.push(row);
    }
  }

  await dataSource.transaction(async (manager) => {
    const repo = manager.getRepository(AnntenaEntity);
    for (const json of parsedRows) {
      const entity = new AnntenaEntity();
      entity.id = json.id;
      entity.categoryId = CATEGORY_IDS[json.category];
      entity.targetCount = json.targetCount ?? null;
      entity.targetModeId = deriveTargetModeId(json);
      entity.dealsDamage = json.dealsDamage ?? false;
      entity.isInheritable = json.isInheritable ?? false;
      entity.evolvesToId = null;
      entity.maxLevel = json.maxLevel ?? null;
      entity.variantGroupId = json.variantGroupId ?? null;
      entity.hasLevel = json.hasLevel ?? true;
      entity.attackAttributes = (json.attackAttributeIds ?? []).map((attributeId) => {
        const attribute = attributeById.get(attributeId);
        if (!attribute) {
          throw new Error(`Unknown attribute id "${attributeId}" for antenna "${json.id}"`);
        }
        return attribute;
      });
      await repo.save(entity);
    }

    const savedById = new Map((await repo.find()).map((entity) => [entity.id, entity]));
    for (const json of parsedRows) {
      if (!json.evolvesToId) continue;
      const entity = savedById.get(json.id)!;
      const evolvesTo = savedById.get(json.evolvesToId);
      if (!evolvesTo) {
        throw new Error(`Unknown evolvesToId "${json.evolvesToId}" for antenna "${json.id}"`);
      }
      entity.evolvesToId = evolvesTo.id;
      await repo.save(entity);
    }
  });
}
