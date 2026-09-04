import { readFile } from 'node:fs/promises';
import path from 'node:path';
import type { DataSource } from 'typeorm';
import { AnntenaEntity } from '../../entities/anntena.entity';
import { MinorCategoryEntity } from '../../entities/minor-category.entity';
import { PhysiqueAntennaCategoryAntennaEntity } from '../../entities/physique-antenna-category-antenna.entity';
import { TranslationEntity } from '../../entities/translation.entity';
import { defaultLocale } from '../../i18n/locale';
import type { DuplicateIdGuard } from '../duplicate-id-guard';

interface PhysiqueAntennaCategoryAntennaJson {
  minorCategoryId: string;
  /** A translated antenna display name, resolved via `TranslationEntity` to find the antenna's `id`. */
  antennaName: string;
}

/**
 * Seeds the small, hand-authored set of antenna-category links. Each row
 * names its antenna by translated display name — never by id —
 * so the loader searches the existing translation data and only creates
 * a link when both the minor category and the antenna are found; rows
 * that don't resolve are skipped with a warning rather than failing the
 * whole seed.
 */
export async function loadPhysiqueAntennaCategoryAntennas(
  dataSource: DataSource,
  dataDir: string,
  guard: DuplicateIdGuard,
): Promise<void> {
  const fileName = 'physique_antenna_category_antennas.json';
  const locale = defaultLocale;

  const rows = JSON.parse(
    await readFile(path.join(dataDir, fileName), 'utf-8'),
  ) as PhysiqueAntennaCategoryAntennaJson[];

  const minorCategoryRepo = dataSource.getRepository(MinorCategoryEntity);
  const translationRepo = dataSource.getRepository(TranslationEntity);
  const anntenaRepo = dataSource.getRepository(AnntenaEntity);

  const entities: PhysiqueAntennaCategoryAntennaEntity[] = [];
  for (const row of rows) {
    const minorCategory = await minorCategoryRepo.findOneBy({ id: row.minorCategoryId });
    if (!minorCategory) {
      console.warn(`Skipping ${fileName} row: unknown minor category "${row.minorCategoryId}"`);
      continue;
    }

    const translation = await translationRepo.findOneBy({
      entityType: 'antenna',
      locale,
      value: row.antennaName,
    });
    if (!translation) {
      console.warn(`Skipping ${fileName} row: no antenna translation found for "${row.antennaName}"`);
      continue;
    }

    const anntena = await anntenaRepo.findOneBy({ id: translation.entityLegacyId });
    if (!anntena) {
      console.warn(`Skipping ${fileName} row: no antenna found for id "${translation.entityLegacyId}"`);
      continue;
    }

    guard.check('physique_antenna_category_antenna', `${minorCategory.id}:${anntena.id}`, fileName);
    const entity = new PhysiqueAntennaCategoryAntennaEntity();
    entity.minorCategoryId = minorCategory.id;
    entity.anntenaId = anntena.id;
    entities.push(entity);
  }

  await dataSource.getRepository(PhysiqueAntennaCategoryAntennaEntity).save(entities);
}
