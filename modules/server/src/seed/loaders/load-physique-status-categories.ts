import { readFile } from 'node:fs/promises';
import path from 'node:path';
import type { DataSource } from 'typeorm';
import { PhysiqueStatusCategoryEntity } from '../../entities/physique-status-category.entity';
import type { DuplicateIdGuard } from '../duplicate-id-guard';

const FILE_NAME = 'physique_status_categories.json';

interface PhysiqueStatusCategoryJson {
  name: string;
  columnCount: number;
}

export async function loadPhysiqueStatusCategories(
  dataSource: DataSource,
  dataDir: string,
  guard: DuplicateIdGuard,
): Promise<void> {
  const filePath = path.join(dataDir, FILE_NAME);
  const rows = JSON.parse(await readFile(filePath, 'utf-8')) as PhysiqueStatusCategoryJson[];

  const entities: PhysiqueStatusCategoryEntity[] = [];
  for (const row of rows) {
    guard.check('physique_status_category', row.name, FILE_NAME);
    const entity = new PhysiqueStatusCategoryEntity();
    entity.name = row.name;
    entity.columnCount = row.columnCount;
    entities.push(entity);
  }

  await dataSource.getRepository(PhysiqueStatusCategoryEntity).save(entities);
}
