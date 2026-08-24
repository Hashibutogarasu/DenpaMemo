import { readFile } from 'node:fs/promises';
import path from 'node:path';
import type { DataSource } from 'typeorm';
import { MonsterEntity } from '../../entities/monster.entity';
import type { DuplicateIdGuard } from '../duplicate-id-guard';

interface IdOnlyJson {
  id: string;
}

/** Mirrors `loadSimpleList`, but keyed off `translateKey` rather than the
 * master-data-specific `legacyId` (`MonsterEntity` is not a `BaseEntity`). */
export async function loadMonsters(
  dataSource: DataSource,
  dataDir: string,
  guard: DuplicateIdGuard,
): Promise<void> {
  const filePath = path.join(dataDir, 'monsters.json');
  const rows = JSON.parse(await readFile(filePath, 'utf-8')) as IdOnlyJson[];

  const entities: MonsterEntity[] = [];
  for (const row of rows) {
    guard.check('monster', row.id, 'monsters.json');
    const entity = new MonsterEntity();
    entity.translateKey = row.id;
    entities.push(entity);
  }

  await dataSource.getRepository(MonsterEntity).save(entities);
}
