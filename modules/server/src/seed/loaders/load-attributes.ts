import { readdir, readFile } from 'node:fs/promises';
import path from 'node:path';
import type { DataSource } from 'typeorm';
import { AttributeEntity } from '../../entities/attribute.entity';
import type { DuplicateIdGuard } from '../duplicate-id-guard';

interface AttributeJson {
  id: string;
  index: number;
  resistantToIds: string[];
  weakToIds: string[];
}

const CATEGORY_DIRS: Array<{ dir: string; categoryId: number }> = [
  { dir: 'elemental', categoryId: 0 },
  { dir: 'special', categoryId: 1 },
];

export async function loadAttributes(
  dataSource: DataSource,
  dataDir: string,
  guard: DuplicateIdGuard,
): Promise<void> {
  const parsedByLegacyId = new Map<string, { json: AttributeJson; categoryId: number }>();

  for (const { dir, categoryId } of CATEGORY_DIRS) {
    const attributesDir = path.join(dataDir, 'attributes', dir);
    const files = await readdir(attributesDir);
    for (const file of files) {
      if (!file.endsWith('.json')) continue;
      const source = path.join('attributes', dir, file);
      const json = JSON.parse(await readFile(path.join(attributesDir, file), 'utf-8')) as AttributeJson;
      guard.check('attribute', json.id, source);
      parsedByLegacyId.set(json.id, { json, categoryId });
    }
  }

  await dataSource.transaction(async (manager) => {
    const entities = [...parsedByLegacyId.values()].map(({ json, categoryId }) => {
      const entity = new AttributeEntity();
      entity.legacyId = json.id;
      entity.index = json.index;
      entity.categoryId = categoryId;
      return entity;
    });
    await manager.save(entities);

    const savedByLegacyId = new Map(entities.map((entity) => [entity.legacyId, entity]));
    for (const { json } of parsedByLegacyId.values()) {
      const entity = savedByLegacyId.get(json.id)!;
      entity.resistantTo = json.resistantToIds.map((id) => savedByLegacyId.get(id)!);
      entity.weakTo = json.weakToIds.map((id) => savedByLegacyId.get(id)!);
      await manager.save(entity);
    }
  });
}
