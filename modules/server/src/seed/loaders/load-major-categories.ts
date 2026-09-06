import { readFile } from 'node:fs/promises';
import path from 'node:path';
import type { DataSource } from 'typeorm';
import { MajorCategoryEntity } from '../../entities/major-category.entity';
import type { DuplicateIdGuard } from '../duplicate-id-guard';

interface MajorCategoryJson {
  id: string;
}

export async function loadMajorCategories(
  dataSource: DataSource,
  dataDir: string,
  guard: DuplicateIdGuard,
): Promise<void> {
  const fileName = 'major_categories.json';
  const filePath = path.join(dataDir, fileName);
  const rows = JSON.parse(await readFile(filePath, 'utf-8')) as MajorCategoryJson[];

  const entities: MajorCategoryEntity[] = [];
  for (const row of rows) {
    guard.check('major_category', row.id, fileName);
    const entity = new MajorCategoryEntity();
    entity.id = row.id;
    entities.push(entity);
  }

  await dataSource.getRepository(MajorCategoryEntity).save(entities);
}
