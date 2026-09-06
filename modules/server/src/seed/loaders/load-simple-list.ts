import { readFile } from 'node:fs/promises';
import path from 'node:path';
import type { DataSource, EntityTarget, ObjectLiteral } from 'typeorm';
import type { DuplicateIdGuard } from '../duplicate-id-guard';

interface IdOnlyJson {
  id: string;
}

export async function loadSimpleList<T extends ObjectLiteral & { id: string }>(
  dataSource: DataSource,
  dataDir: string,
  fileName: string,
  entityType: string,
  entityTarget: EntityTarget<T>,
  guard: DuplicateIdGuard,
): Promise<void> {
  const filePath = path.join(dataDir, fileName);
  const rows = JSON.parse(await readFile(filePath, 'utf-8')) as IdOnlyJson[];

  const entities: T[] = [];
  for (const row of rows) {
    guard.check(entityType, row.id, fileName);
    const entity = new (entityTarget as { new (): T })();
    entity.id = row.id;
    entities.push(entity);
  }

  await dataSource.getRepository(entityTarget).save(entities);
}
