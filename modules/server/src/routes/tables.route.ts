import { Elysia } from 'elysia';
import type { DataSource } from 'typeorm';
import type { z } from 'zod';
import { findEvasionRateMatches } from '../domain/physique/evasion-rate-search';
import { TABLE_ENTITY_MAPPING, type TableEntityMapping } from '../domain/physique/table-registry';
import { PhysiqueAntennaCategoryEntity } from '../entities/physique-antenna-category.entity';
import { TableDefinitionEntity } from '../entities/table-definition.entity';
import {
  deleteTablesQuerySchema,
  getTablesQuerySchema,
  postTablesBodySchema,
  putTablesBodySchema,
  putTablesBodySchemaWithBounds,
  searchTablesQuerySchema,
} from './tables.schema';

function zodErrorResponse(error: z.ZodError) {
  return { error: 'validation_error', issues: error.issues };
}

function unknownTypeResponse(type: string) {
  return {
    error: 'validation_error',
    issues: [{ message: `Unknown table type "${type}"`, path: ['type'] }],
  };
}

function columnCountMismatchResponse(type: string, expected: number, actual: number) {
  return {
    error: 'validation_error',
    issues: [
      {
        message: `"${type}" rows must have ${expected} values, got ${actual}`,
        path: ['values'],
      },
    ],
  };
}

interface ResolvedTableType extends TableEntityMapping {
  columnCount: number;
}

/**
 * Resolves a `type` into everything needed to operate on it: row width
 * from the DB-driven `TableDefinitionEntity` (seeded from
 * `data/table_definitions.json`), and the entity/discriminator from the
 * code-level `TABLE_ENTITY_MAPPING`. `undefined` if either half is
 * missing — i.e. an unregistered type.
 */
async function resolveTableType(dataSource: DataSource, type: string): Promise<ResolvedTableType | undefined> {
  const definition = await dataSource.getRepository(TableDefinitionEntity).findOne({ where: { type } });
  const mapping = TABLE_ENTITY_MAPPING[type];
  if (!definition || !mapping) {
    return undefined;
  }
  return { columnCount: definition.columnCount, ...mapping };
}

function whereFor(resolved: TableEntityMapping, filters: { level?: string; anntenaCategory?: string }) {
  const where: Record<string, unknown> = {};
  if (resolved.discriminator) {
    where[resolved.discriminator.column] = resolved.discriminator.value;
  }
  if (filters.level !== undefined) where.level = filters.level;
  if (filters.anntenaCategory !== undefined) where.anntenaCategory = filters.anntenaCategory;
  return where;
}

/**
 * Deletes the rows at `lineOffsets` within one type's `level`/
 * `anntenaCategory` group, then re-sequences the remaining rows'
 * `lineOffset`s back to a contiguous `0..n-1` range so `PUT /tables`
 * (which indexes into the table by array position) stays gap-free after
 * a delete. Generalized from the physique-table-only version this
 * replaces: parameterized by the resolved type instead of hardcoding
 * `PhysiqueTableEntity`/`statusCategory`.
 */
async function deleteTableRows(
  dataSource: DataSource,
  resolved: ResolvedTableType,
  level: string,
  anntenaCategory: string,
  lineOffsets: number[],
): Promise<void> {
  const offsetsToDelete = new Set(lineOffsets);
  await dataSource.transaction(async (manager) => {
    const txRepo = manager.getRepository(resolved.entity);
    const rows = await txRepo.find({
      where: whereFor(resolved, { level, anntenaCategory }),
      order: { lineOffset: 'ASC' },
    });

    const toDelete = rows.filter((row) => offsetsToDelete.has(row.lineOffset));
    if (toDelete.length > 0) {
      await txRepo.remove(toDelete);
    }

    const remaining = rows.filter((row) => !offsetsToDelete.has(row.lineOffset));
    for (let i = 0; i < remaining.length; i += 1) {
      if (remaining[i].lineOffset !== i) {
        remaining[i].lineOffset = i;
        await txRepo.save(remaining[i]);
      }
    }
  });
}

/**
 * Generic REST CRUD + cross-table search for every registered "table
 * type" (see `src/domain/physique/table-registry.ts` and
 * `TableDefinitionEntity`), replacing what used to be one route module
 * per physical table. Adding a new table type never needs a new route —
 * only a new registry entry and `table_definitions.json` row.
 */
export function tablesRoutes(dataSource: DataSource) {
  const categoryRepo = dataSource.getRepository(PhysiqueAntennaCategoryEntity);

  return new Elysia().group('/tables', (app) =>
    app
      .get('/types', async () => {
        const definitions = await dataSource
          .getRepository(TableDefinitionEntity)
          .find({ where: {}, order: { type: 'ASC' } });
        return definitions
          .filter((definition) => definition.type in TABLE_ENTITY_MAPPING)
          .map((definition) => ({
            type: definition.type,
            columnCount: definition.columnCount,
            translationKey: definition.translationKey,
          }));
      })
      .post('/', async ({ body, set }) => {
        const parsed = postTablesBodySchema.safeParse(body);
        if (!parsed.success) {
          set.status = 400;
          return zodErrorResponse(parsed.error);
        }
        const records = Array.isArray(parsed.data) ? parsed.data : [parsed.data];

        const resolvedByType = new Map<string, ResolvedTableType>();
        for (const record of records) {
          if (!resolvedByType.has(record.type)) {
            const resolved = await resolveTableType(dataSource, record.type);
            if (!resolved) {
              set.status = 400;
              return unknownTypeResponse(record.type);
            }
            resolvedByType.set(record.type, resolved);
          }
          const resolved = resolvedByType.get(record.type)!;
          if (record.values.length !== resolved.columnCount) {
            set.status = 400;
            return columnCountMismatchResponse(record.type, resolved.columnCount, record.values.length);
          }
        }

        const saved: unknown[] = [];
        for (const record of records) {
          const resolved = resolvedByType.get(record.type)!;
          const repo = dataSource.getRepository(resolved.entity);

          let lineOffset = record.lineOffset;
          if (lineOffset === undefined) {
            lineOffset = await repo.count({
              where: whereFor(resolved, { level: record.level, anntenaCategory: record.anntenaCategory }),
            });
          }

          const entity = repo.create({
            level: record.level,
            anntenaCategory: record.anntenaCategory,
            lineOffset,
            values: record.values,
            ...(resolved.discriminator ? { [resolved.discriminator.column]: resolved.discriminator.value } : {}),
          });
          saved.push(await repo.save(entity));
        }

        set.status = 201;
        return saved;
      })
      .get('/', async ({ query, set }) => {
        const parsed = getTablesQuerySchema.safeParse(query);
        if (!parsed.success) {
          set.status = 400;
          return zodErrorResponse(parsed.error);
        }
        const { type, level, anntenaCategory, category } = parsed.data;

        const resolved = await resolveTableType(dataSource, type);
        if (!resolved) {
          set.status = 400;
          return unknownTypeResponse(type);
        }
        const repo = dataSource.getRepository(resolved.entity);

        let anntenaCategoryFilter: string[] | undefined;
        if (category !== undefined) {
          const rows = await categoryRepo.find({ where: { category } });
          anntenaCategoryFilter = rows.map((row) => row.anntenaCategory);
        }

        if (anntenaCategoryFilter !== undefined) {
          if (anntenaCategoryFilter.length === 0) {
            return [];
          }
          const qb = repo
            .createQueryBuilder('row')
            .where('row.anntenaCategory IN (:...anntenaCategoryFilter)', { anntenaCategoryFilter })
            .orderBy('row.lineOffset', 'ASC');
          if (resolved.discriminator) {
            qb.andWhere(`row.${resolved.discriminator.column} = :discriminatorValue`, {
              discriminatorValue: resolved.discriminator.value,
            });
          }
          if (level !== undefined) {
            qb.andWhere('row.level = :level', { level });
          }
          if (anntenaCategory !== undefined) {
            qb.andWhere('row.anntenaCategory = :anntenaCategory', { anntenaCategory });
          }
          return qb.getMany();
        }

        return repo.find({
          where: whereFor(resolved, { level, anntenaCategory }),
          order: { lineOffset: 'ASC' },
        });
      })
      .put('/', async ({ body, set }) => {
        const shapeParsed = putTablesBodySchema.safeParse(body);
        if (!shapeParsed.success) {
          set.status = 400;
          return zodErrorResponse(shapeParsed.error);
        }
        const { type, lineOffset, level, anntenaCategory, records } = shapeParsed.data;

        const resolved = await resolveTableType(dataSource, type);
        if (!resolved) {
          set.status = 400;
          return unknownTypeResponse(type);
        }
        const repo = dataSource.getRepository(resolved.entity);

        const mismatched = records.find((record) => record.values.length !== resolved.columnCount);
        if (mismatched) {
          set.status = 400;
          return columnCountMismatchResponse(type, resolved.columnCount, mismatched.values.length);
        }

        const currentRowCount = await repo.count({ where: whereFor(resolved, { level, anntenaCategory }) });
        const boundedParsed = putTablesBodySchemaWithBounds(currentRowCount).safeParse(body);
        if (!boundedParsed.success) {
          set.status = 400;
          return zodErrorResponse(boundedParsed.error);
        }

        const targetRows = await repo.find({
          where: whereFor(resolved, { level, anntenaCategory }),
          order: { lineOffset: 'ASC' },
        });

        const updated: unknown[] = [];
        for (let i = 0; i < records.length; i += 1) {
          const target = targetRows[lineOffset + i];
          target.values = records[i].values;
          updated.push(await repo.save(target));
        }

        return updated;
      })
      .delete('/', async ({ query, set }) => {
        const parsed = deleteTablesQuerySchema.safeParse(query);
        if (!parsed.success) {
          set.status = 400;
          return zodErrorResponse(parsed.error);
        }
        const { type, level, anntenaCategory, lineOffsets } = parsed.data;

        const resolved = await resolveTableType(dataSource, type);
        if (!resolved) {
          set.status = 400;
          return unknownTypeResponse(type);
        }

        if (lineOffsets !== undefined) {
          // level and anntenaCategory are both required alongside lineOffsets
          // (enforced by deleteTablesQuerySchema's refine).
          await deleteTableRows(dataSource, resolved, level!, anntenaCategory!, lineOffsets);
          set.status = 204;
          return null;
        }

        const repo = dataSource.getRepository(resolved.entity);
        await repo.delete(whereFor(resolved, { level, anntenaCategory }));
        set.status = 204;
        return null;
      })
      .get('/search', async ({ query, set }) => {
        const parsed = searchTablesQuerySchema.safeParse(query);
        if (!parsed.success) {
          set.status = 400;
          return zodErrorResponse(parsed.error);
        }
        const { type, against, evasionRate, hp, anntenaCategory, category } = parsed.data;

        const primary = await resolveTableType(dataSource, type);
        if (!primary) {
          set.status = 400;
          return unknownTypeResponse(type);
        }
        const target = await resolveTableType(dataSource, against);
        if (!target) {
          set.status = 400;
          return unknownTypeResponse(against);
        }

        let anntenaCategoryFilter: string[] | undefined;
        if (category !== undefined) {
          const rows = await categoryRepo.find({ where: { category } });
          anntenaCategoryFilter = rows.map((row) => row.anntenaCategory);
          if (anntenaCategoryFilter.length === 0) {
            return [];
          }
        }

        const filters =
          anntenaCategory !== undefined ? { anntenaCategory } : {};

        const primaryRepo = dataSource.getRepository(primary.entity);
        const targetRepo = dataSource.getRepository(target.entity);

        const [primaryRows, targetRows] =
          anntenaCategoryFilter !== undefined
            ? await Promise.all([
                primaryRepo
                  .createQueryBuilder('row')
                  .where('row.anntenaCategory IN (:...anntenaCategoryFilter)', { anntenaCategoryFilter })
                  .getMany(),
                targetRepo
                  .createQueryBuilder('row')
                  .where('row.anntenaCategory IN (:...anntenaCategoryFilter)', { anntenaCategoryFilter })
                  .getMany(),
              ])
            : await Promise.all([
                primaryRepo.find({ where: whereFor(primary, filters) }),
                targetRepo.find({ where: whereFor(target, filters) }),
              ]);

        return findEvasionRateMatches(primaryRows, targetRows, evasionRate, hp);
      }),
  );
}
