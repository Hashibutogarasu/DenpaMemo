import { readFile } from 'node:fs/promises';
import path from 'node:path';
import type { DataSource } from 'typeorm';
import { MinorCategoryEntity } from '../../entities/minor-category.entity';
import { PhysiqueAntennaCategoryEntity } from '../../entities/physique-antenna-category.entity';
import type { DuplicateIdGuard } from '../duplicate-id-guard';

interface MinorCategoryJson {
  id: string;
  majorCategoryId: string;
}

interface PhysiqueAntennaCategoryJson {
  category: string;
  anntenaCategory: string;
}

/**
 * Bridges each row to its `PhysiqueAntennaCategoryEntity` counterpart by
 * array position against `physique_antenna_categories.json`, rather than
 * duplicating that file's Japanese text into `minor_categories.json` —
 * this file holds nothing but English-word ids.
 */
export async function loadMinorCategories(
  dataSource: DataSource,
  dataDir: string,
  guard: DuplicateIdGuard,
): Promise<void> {
  const fileName = 'minor_categories.json';
  const physiqueAntennaCategoryFileName = 'physique_antenna_categories.json';

  const rows = JSON.parse(await readFile(path.join(dataDir, fileName), 'utf-8')) as MinorCategoryJson[];
  const physiqueAntennaCategoryRows = JSON.parse(
    await readFile(path.join(dataDir, physiqueAntennaCategoryFileName), 'utf-8'),
  ) as PhysiqueAntennaCategoryJson[];

  if (rows.length !== physiqueAntennaCategoryRows.length) {
    throw new Error(
      `${fileName} has ${rows.length} rows but ${physiqueAntennaCategoryFileName} has ${physiqueAntennaCategoryRows.length} — they must correspond 1:1 by position`,
    );
  }

  const physiqueAntennaCategoryRepo = dataSource.getRepository(PhysiqueAntennaCategoryEntity);

  const entities: MinorCategoryEntity[] = [];
  for (const [index, row] of rows.entries()) {
    const physiqueAntennaCategory = await physiqueAntennaCategoryRepo.findOneByOrFail({
      anntenaCategory: physiqueAntennaCategoryRows[index].anntenaCategory,
    });

    guard.check('minor_category', row.id, fileName);
    const entity = new MinorCategoryEntity();
    entity.id = row.id;
    entity.majorCategoryId = row.majorCategoryId;
    entity.physiqueAntennaCategoryId = physiqueAntennaCategory.id;
    entities.push(entity);
  }

  await dataSource.getRepository(MinorCategoryEntity).save(entities);
}
