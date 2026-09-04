import type { DataSource } from 'typeorm';
import { PhysiqueAntennaCategoryEntity } from '../entities/physique-antenna-category.entity';
import { TableDefinitionEntity } from '../entities/table-definition.entity';
import { TABLE_ENTITY_MAPPING } from '../domain/physique/table-registry';
import { whereFor } from '../domain/tables/table-operations';

/**
 * Fills in every missing row, for level 1-200 crossed with every
 * registered antenna category, on each registered physique table type
 * (`TABLE_ENTITY_MAPPING`) — `hp`, `speed`, and `evasionRate` alike —
 * the first time the server boots against an empty table. Must run
 * after `seedPhysiqueAntennaCategoriesIfNeeded`/`seedTableDefinitionsIfNeeded`.
 */
export async function seedPhysiqueTableDefaultsIfNeeded(dataSource: DataSource): Promise<void> {
  const minLevel = 1;
  const maxLevel = 200;
  const saveChunkSize = 500;

  const antennaCategories = await dataSource.getRepository(PhysiqueAntennaCategoryEntity).find();
  const definitionRepo = dataSource.getRepository(TableDefinitionEntity);

  for (const [type, mapping] of Object.entries(TABLE_ENTITY_MAPPING)) {
    const definition = await definitionRepo.findOne({ where: { type } });
    if (!definition) {
      continue;
    }

    const repo = dataSource.getRepository(mapping.entity);
    const existingCount = await repo.count({ where: whereFor(mapping, {}) });
    if (existingCount > 0) {
      continue;
    }

    const rows = antennaCategories.flatMap(({ anntenaCategory }) =>
      Array.from({ length: maxLevel - minLevel + 1 }, (_, index) =>
        repo.create({
          level: String(minLevel + index),
          anntenaCategory,
          lineOffset: 0,
          values: new Array(definition.columnCount).fill(0),
          ...(mapping.discriminator ? { [mapping.discriminator.column]: mapping.discriminator.value } : {}),
        } as never),
      ),
    );

    const progressStepPercent = 10;
    let lastLoggedPercent = 0;
    for (let i = 0; i < rows.length; i += saveChunkSize) {
      await repo.save(rows.slice(i, i + saveChunkSize) as never[]);

      const savedCount = Math.min(i + saveChunkSize, rows.length);
      const percent = Math.floor((savedCount / rows.length) * 100);
      if (percent >= lastLoggedPercent + progressStepPercent) {
        lastLoggedPercent = percent - (percent % progressStepPercent);
        console.log(`Seeding "${type}" table defaults: ${lastLoggedPercent}% (${savedCount}/${rows.length})`);
      }
    }
  }
}
