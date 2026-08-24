import path from 'node:path';
import type { DataSource } from 'typeorm';
import { ANTENNA_CATEGORY_SEED_ROWS, AntennaCategoryEntity } from '../entities/antenna-category.entity';
import { ATTRIBUTE_CATEGORY_SEED_ROWS, AttributeCategoryEntity } from '../entities/attribute-category.entity';
import { HeadShapeEntity } from '../entities/head-shape.entity';
import { TARGET_MODE_SEED_ROWS, TargetModeEntity } from '../entities/target-mode.entity';
import { DuplicateIdGuard } from './duplicate-id-guard';
import { loadAntennas } from './loaders/load-antennas';
import { loadAttributes } from './loaders/load-attributes';
import { loadBodyColorAbnormalityResistanceRules, loadBodyColorResistanceRules } from './loaders/load-body-color-rules';
import { loadCorrections } from './loaders/load-corrections';
import { loadHeadShapes } from './loaders/load-head-shapes';
import { loadMonsters } from './loaders/load-monsters';
import { loadSimpleList } from './loaders/load-simple-list';
import { loadTranslations } from './loaders/load-translations';
import { AbnormalityTypeEntity } from '../entities/abnormality-type.entity';
import { PhysiqueEntity } from '../entities/physique.entity';
import { PersonalityEntity } from '../entities/personality.entity';
import { PatternEntity } from '../entities/pattern.entity';

const DATA_DIR = path.resolve(import.meta.dirname, '..', '..', 'data');

export async function runSeedIfNeeded(dataSource: DataSource, dataDir: string = DATA_DIR): Promise<void> {
  const headShapeCount = await dataSource.getRepository(HeadShapeEntity).count();
  if (headShapeCount > 0) {
    console.log('Master data already seeded, skipping.');
    return;
  }

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
}
