import path from 'node:path';
import type { DataSource } from 'typeorm';
import { ANTENNA_CATEGORY_SEED_ROWS, AntennaCategoryEntity } from '../entities/antenna-category.entity';
import { ATTRIBUTE_CATEGORY_SEED_ROWS, AttributeCategoryEntity } from '../entities/attribute-category.entity';
import { HeadShapeEntity } from '../entities/head-shape.entity';
import { PhysiqueAntennaCategoryEntity } from '../entities/physique-antenna-category.entity';
import { PhysiqueStatusCategoryEntity } from '../entities/physique-status-category.entity';
import { TableDefinitionEntity } from '../entities/table-definition.entity';
import { TARGET_MODE_SEED_ROWS, TargetModeEntity } from '../entities/target-mode.entity';
import { DuplicateIdGuard } from './duplicate-id-guard';
import { loadAntennas } from './loaders/load-antennas';
import { loadAttributes } from './loaders/load-attributes';
import { loadBodyColorAbnormalityResistanceRules, loadBodyColorResistanceRules } from './loaders/load-body-color-rules';
import { loadCorrections } from './loaders/load-corrections';
import { loadHeadShapes } from './loaders/load-head-shapes';
import { loadMonsters } from './loaders/load-monsters';
import { loadPhysiqueAntennaCategories } from './loaders/load-physique-antenna-categories';
import { loadPhysiqueStatusCategories } from './loaders/load-physique-status-categories';
import { loadSimpleList } from './loaders/load-simple-list';
import { loadTableDefinitions } from './loaders/load-table-definitions';
import { loadTranslations } from './loaders/load-translations';
import { AbnormalityTypeEntity } from '../entities/abnormality-type.entity';
import { PhysiqueEntity } from '../entities/physique.entity';
import { PersonalityEntity } from '../entities/personality.entity';
import { PatternEntity } from '../entities/pattern.entity';
import { MajorCategoryEntity } from '../entities/major-category.entity';
import { MinorCategoryEntity } from '../entities/minor-category.entity';
import { PhysiqueAntennaCategoryAntennaEntity } from '../entities/physique-antenna-category-antenna.entity';
import { PhysiqueEvasionRateCategoryEntity } from '../entities/physique-evasion-rate-category.entity';
import { loadMajorCategories } from './loaders/load-major-categories';
import { loadMinorCategories } from './loaders/load-minor-categories';
import { loadPhysiqueAntennaCategoryAntennas } from './loaders/load-physique-antenna-category-antennas';
import { loadPhysiqueEvasionRateCategories } from './loaders/load-physique-evasion-rate-categories';
import { seedPhysiqueTableDefaultsIfNeeded } from './seed-physique-table-defaults';

const DATA_DIR = path.resolve(import.meta.dirname, '..', '..', 'data');

export async function runSeedIfNeeded(dataSource: DataSource, dataDir: string = DATA_DIR): Promise<void> {
  const headShapeCount = await dataSource.getRepository(HeadShapeEntity).count();
  if (headShapeCount === 0) {
    const guard = new DuplicateIdGuard();

    await dataSource.getRepository(TargetModeEntity).save([...TARGET_MODE_SEED_ROWS]);
    await dataSource.getRepository(AntennaCategoryEntity).save([...ANTENNA_CATEGORY_SEED_ROWS]);
    await dataSource.getRepository(AttributeCategoryEntity).save([...ATTRIBUTE_CATEGORY_SEED_ROWS]);

    await loadAttributes(dataSource, dataDir, guard);
    await loadHeadShapes(dataSource, dataDir, guard);
    await loadAntennas(dataSource, dataDir, guard);
    await loadBodyColorResistanceRules(dataSource, dataDir, guard);
    await loadBodyColorAbnormalityResistanceRules(dataSource, dataDir, guard);

    await loadSimpleList(dataSource, dataDir, 'abnormality_types.json', 'abnormality_type', AbnormalityTypeEntity, guard);
    await loadSimpleList(dataSource, dataDir, 'physiques.json', 'physique', PhysiqueEntity, guard);
    await loadSimpleList(dataSource, dataDir, 'personalities.json', 'personality', PersonalityEntity, guard);
    await loadSimpleList(dataSource, dataDir, 'patterns.json', 'pattern', PatternEntity, guard);
    await loadCorrections(dataSource, dataDir, guard);
    await loadMonsters(dataSource, dataDir, guard);

    await loadTranslations(dataSource, dataDir);

    console.log('Master data seeded.');
  } else {
    console.log('Master data already seeded, skipping.');
  }

  await seedPhysiqueAntennaCategoriesIfNeeded(dataSource, dataDir);
  await seedPhysiqueStatusCategoriesIfNeeded(dataSource, dataDir);
  await seedTableDefinitionsIfNeeded(dataSource, dataDir);
  await seedPhysiqueTableDefaultsIfNeeded(dataSource);
  await seedMajorCategoriesIfNeeded(dataSource, dataDir);
  await seedMinorCategoriesIfNeeded(dataSource, dataDir);
  await seedPhysiqueAntennaCategoryAntennasIfNeeded(dataSource, dataDir);
  await seedPhysiqueEvasionRateCategoriesIfNeeded(dataSource, dataDir);
}

/**
 * Seeded independently of the `headShapeCount` gate above: this entity was
 * added after that gate started guarding every other master-data table, so
 * a database seeded before this feature existed would otherwise never get
 * these rows. Guarded by its own count instead.
 */
async function seedPhysiqueAntennaCategoriesIfNeeded(dataSource: DataSource, dataDir: string): Promise<void> {
  const physiqueAntennaCategoryCount = await dataSource.getRepository(PhysiqueAntennaCategoryEntity).count();
  if (physiqueAntennaCategoryCount > 0) {
    return;
  }
  await loadPhysiqueAntennaCategories(dataSource, dataDir, new DuplicateIdGuard());
}

/** Same independent-gate reasoning as {@link seedPhysiqueAntennaCategoriesIfNeeded}. */
async function seedPhysiqueStatusCategoriesIfNeeded(dataSource: DataSource, dataDir: string): Promise<void> {
  const physiqueStatusCategoryCount = await dataSource.getRepository(PhysiqueStatusCategoryEntity).count();
  if (physiqueStatusCategoryCount > 0) {
    return;
  }
  await loadPhysiqueStatusCategories(dataSource, dataDir, new DuplicateIdGuard());
}

/** Same independent-gate reasoning as {@link seedPhysiqueAntennaCategoriesIfNeeded}. */
async function seedTableDefinitionsIfNeeded(dataSource: DataSource, dataDir: string): Promise<void> {
  const tableDefinitionCount = await dataSource.getRepository(TableDefinitionEntity).count();
  if (tableDefinitionCount > 0) {
    return;
  }
  await loadTableDefinitions(dataSource, dataDir, new DuplicateIdGuard());
}

/** Same independent-gate reasoning as {@link seedPhysiqueAntennaCategoriesIfNeeded}. */
async function seedPhysiqueEvasionRateCategoriesIfNeeded(dataSource: DataSource, dataDir: string): Promise<void> {
  const categoryCount = await dataSource.getRepository(PhysiqueEvasionRateCategoryEntity).count();
  if (categoryCount > 0) {
    return;
  }
  await loadPhysiqueEvasionRateCategories(dataSource, dataDir);
}

/** Same independent-gate reasoning as {@link seedPhysiqueAntennaCategoriesIfNeeded}. */
async function seedMajorCategoriesIfNeeded(dataSource: DataSource, dataDir: string): Promise<void> {
  const majorCategoryCount = await dataSource.getRepository(MajorCategoryEntity).count();
  if (majorCategoryCount > 0) {
    return;
  }
  await loadMajorCategories(dataSource, dataDir, new DuplicateIdGuard());
}

/** Must run after {@link seedMajorCategoriesIfNeeded} and {@link seedPhysiqueAntennaCategoriesIfNeeded}. */
async function seedMinorCategoriesIfNeeded(dataSource: DataSource, dataDir: string): Promise<void> {
  const minorCategoryCount = await dataSource.getRepository(MinorCategoryEntity).count();
  if (minorCategoryCount > 0) {
    return;
  }
  await loadMinorCategories(dataSource, dataDir, new DuplicateIdGuard());
}

/** Must run after {@link seedMinorCategoriesIfNeeded} and the main translations load. */
async function seedPhysiqueAntennaCategoryAntennasIfNeeded(dataSource: DataSource, dataDir: string): Promise<void> {
  const linkCount = await dataSource.getRepository(PhysiqueAntennaCategoryAntennaEntity).count();
  if (linkCount > 0) {
    return;
  }
  await loadPhysiqueAntennaCategoryAntennas(dataSource, dataDir, new DuplicateIdGuard());
}
