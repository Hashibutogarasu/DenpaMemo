import { Elysia } from 'elysia';
import type { DataSource } from 'typeorm';
import type { z } from 'zod';
import { findEvasionRateMatches } from '../domain/physique/evasion-rate-search';
import { TABLE_ENTITY_MAPPING } from '../domain/physique/table-registry';
import {
  deleteTableRows,
  resolveTableType,
  serializeRow,
  whereFor,
  type ResolvedTableType,
  type TableRow,
} from '../domain/tables/table-operations';
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

/**
 * Generic REST CRUD + cross-table search for every registered "table
 * type" in the physique domain's registry (`TABLE_ENTITY_MAPPING`) and
 * `TableDefinitionEntity`, replacing what used to be one route module per
 * physical table. The actual table mechanics (resolving a type, building
 * queries, serializing rows, delete+resequence) live in
 * `src/domain/tables/table-operations.ts`, domain-agnostic — a future
 * non-physique table registry would reuse those, not this route file.
 * Adding a new physique table type never needs a new route — only a new
 * registry entry and `table_definitions.json` row.
 */
export function tablesRoutes(dataSource: DataSource) {
  const categoryRepo = dataSource.getRepository(PhysiqueAntennaCategoryEntity);

  const resolve = (type: string) => resolveTableType(dataSource, type, TABLE_ENTITY_MAPPING);

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
            const resolved = await resolve(record.type);
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
          const row = (await repo.save(entity)) as unknown as TableRow;
          saved.push(serializeRow(record.type, resolved.columnCount, row));
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

        const resolved = await resolve(type);
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

        let rows: TableRow[];
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
          rows = (await qb.getMany()) as unknown as TableRow[];
        } else {
          rows = (await repo.find({
            where: whereFor(resolved, { level, anntenaCategory }),
            order: { lineOffset: 'ASC' },
          })) as unknown as TableRow[];
        }

        return rows.map((row) => serializeRow(type, resolved.columnCount, row));
      })
      .put('/', async ({ body, set }) => {
        const shapeParsed = putTablesBodySchema.safeParse(body);
        if (!shapeParsed.success) {
          set.status = 400;
          return zodErrorResponse(shapeParsed.error);
        }
        const { type, lineOffset, level, anntenaCategory, records } = shapeParsed.data;

        const resolved = await resolve(type);
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

        const targetRows = (await repo.find({
          where: whereFor(resolved, { level, anntenaCategory }),
          order: { lineOffset: 'ASC' },
        })) as unknown as TableRow[];

        const updated: ReturnType<typeof serializeRow>[] = [];
        for (let i = 0; i < records.length; i += 1) {
          const target = targetRows[lineOffset + i];
          target.values = records[i].values;
          const saved = (await repo.save(target as never)) as unknown as TableRow;
          updated.push(serializeRow(type, resolved.columnCount, saved));
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

        const resolved = await resolve(type);
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

        const primary = await resolve(type);
        if (!primary) {
          set.status = 400;
          return unknownTypeResponse(type);
        }
        const target = await resolve(against);
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

        const filters = anntenaCategory !== undefined ? { anntenaCategory } : {};

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
