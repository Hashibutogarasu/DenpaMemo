import { readFile } from 'node:fs/promises';
import path from 'node:path';
import type { DataSource } from 'typeorm';
import { PhysiqueAntennaCategoryEntity } from '../../entities/physique-antenna-category.entity';
import type { DuplicateIdGuard } from '../duplicate-id-guard';

const FILE_NAME = 'physique_antenna_categories.json';

interface PhysiqueAntennaCategoryJson {
  category: string;
  anntenaCategory: string;
}

export async function loadPhysiqueAntennaCategories(
  dataSource: DataSource,
  dataDir: string,
  guard: DuplicateIdGuard,
): Promise<void> {
  const filePath = path.join(dataDir, FILE_NAME);
  const rows = JSON.parse(await readFile(filePath, 'utf-8')) as PhysiqueAntennaCategoryJson[];

  const entities: PhysiqueAntennaCategoryEntity[] = [];
  for (const row of rows) {
    guard.check('physique_antenna_category', row.anntenaCategory, FILE_NAME);
    const entity = new PhysiqueAntennaCategoryEntity();
    entity.category = row.category;
    entity.anntenaCategory = row.anntenaCategory;
    entities.push(entity);
  }

  await dataSource.getRepository(PhysiqueAntennaCategoryEntity).save(entities);
}
