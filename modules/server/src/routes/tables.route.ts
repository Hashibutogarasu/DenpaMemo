import { Elysia, NotFoundError } from 'elysia';
import type { DataSource } from 'typeorm';
import type { z } from 'zod';
import { createAntennaCategoryLinkDataSource } from '../domain/physique/antenna-category-link-data-source';
import { findEvasionRateMatches } from '../domain/physique/evasion-rate-search';
import { buildLegendGrid } from '../domain/physique/legend-grid';
import { resolvePhysiqueCategoryKeys, type PhysiqueEvasionRateCategoryRow } from '../domain/physique/physique-evasion-rate-category';
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
import { PhysiqueEvasionRateCategoryEntity } from '../entities/physique-evasion-rate-category.entity';
import { TableDefinitionEntity } from '../entities/table-definition.entity';
import { parseAcceptLanguage } from '../http/accept-language';
import { categoryTranslator } from '../i18n/i18n';
import {
  deleteTablesQuerySchema,
  getTablesQuerySchema,
  legendGridQuerySchema,
  postTablesBodySchema,
  putTablesBodySchema,
  putTablesBodySchemaWithBounds,
  searchTablesQuerySchema,
} from './tables.schema';

function zodErrorResponse(error: z.ZodError) {
  return { error: 'validation_error', issues: error.issues };
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
  const evasionRateCategoryRepo = dataSource.getRepository(PhysiqueEvasionRateCategoryEntity);
  const linkDataSource = createAntennaCategoryLinkDataSource(dataSource);

  /** Resolves `type`, throwing [NotFoundError] rather than returning `undefined` for an unregistered one. */
  async function resolve(type: string): Promise<ResolvedTableType> {
    const resolved = await resolveTableType(dataSource, type, TABLE_ENTITY_MAPPING);
    if (!resolved) throw new NotFoundError(`Unknown table type "${type}"`);
    return resolved;
  }

  /** Resolves an antenna id to its physique table `anntenaCategory` string, throwing [NotFoundError] if unknown. */
  async function resolveAntennaCategory(antennaId: string, locale: string): Promise<string> {
    const unknown = () => new NotFoundError(`Unknown antenna "${antennaId}"`);

    const anntena = await linkDataSource.findAntennaById(antennaId);
    if (!anntena) throw unknown();
    const link = await linkDataSource.findLinkForAntenna(anntena.id);
    if (!link) throw unknown();
    const category = categoryTranslator.translateMinorCategory(link.minorCategoryId, locale);
    if (category === undefined) throw unknown();
    return category;
  }

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
            resolvedByType.set(record.type, await resolve(record.type));
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
      .get('/search', async ({ query, set, headers }) => {
        const parsed = searchTablesQuerySchema.safeParse(query);
        if (!parsed.success) {
          set.status = 400;
          return zodErrorResponse(parsed.error);
        }
        const { type, against, evasionRate, hp, level, anntenaCategory, category, antenna } = parsed.data;

        const primary = await resolve(type);
        const target = await resolve(against);
        const locale = parseAcceptLanguage(headers['accept-language']);

        let resolvedAnntenaCategory = anntenaCategory;
        if (antenna !== undefined) {
          resolvedAnntenaCategory = await resolveAntennaCategory(antenna, locale);
        }

        let anntenaCategoryFilter: string[] | undefined;
        if (category !== undefined) {
          const rows = await categoryRepo.find({ where: { category } });
          anntenaCategoryFilter = rows.map((row) => row.anntenaCategory);
          if (anntenaCategoryFilter.length === 0) {
            return [];
          }
        }

        const filters = resolvedAnntenaCategory !== undefined ? { level, anntenaCategory: resolvedAnntenaCategory } : { level };

        const primaryRepo = dataSource.getRepository(primary.entity);
        const targetRepo = dataSource.getRepository(target.entity);

        const buildFilteredQuery = (repo: typeof primaryRepo, resolved: ResolvedTableType) => {
          const qb = repo
            .createQueryBuilder('row')
            .where('row.anntenaCategory IN (:...anntenaCategoryFilter)', { anntenaCategoryFilter });
          if (resolved.discriminator) {
            qb.andWhere(`row.${resolved.discriminator.column} = :discriminatorValue`, {
              discriminatorValue: resolved.discriminator.value,
            });
          }
          if (level !== undefined) {
            qb.andWhere('row.level = :level', { level });
          }
          if (resolvedAnntenaCategory !== undefined) {
            qb.andWhere('row.anntenaCategory = :anntenaCategory', { anntenaCategory: resolvedAnntenaCategory });
          }
          return qb.getMany();
        };

        const [primaryRows, targetRows] =
          anntenaCategoryFilter !== undefined
            ? await Promise.all([buildFilteredQuery(primaryRepo, primary), buildFilteredQuery(targetRepo, target)])
            : await Promise.all([
                primaryRepo.find({ where: whereFor(primary, filters) }),
                targetRepo.find({ where: whereFor(target, filters) }),
              ]);

        const matches = findEvasionRateMatches(primaryRows as TableRow[], targetRows as TableRow[], evasionRate, hp);
        const results = await Promise.all(
          matches.map(async (match) => {
            const candidates = await resolvePhysiqueCategoryKeys(evasionRateCategoryRepo, evasionRate, match.columnIndex);
            return {
              ...match,
              candidates: candidates.map((candidate) => ({
                textKey: candidate.textKey,
                text: categoryTranslator.translatePhysique(candidate.textKey, locale) ?? null,
                sign: candidate.sign,
                evasionRateStart: candidate.evasionRateStart,
                evasionRateEnd: candidate.evasionRateEnd,
              })),
            };
          }),
        );

        const info =
          results.length === 0 || results.every((result) => result.candidates.length === 0)
            ? {
                query: { type, against, evasionRate, hp, level, antenna, anntenaCategory: resolvedAnntenaCategory },
                primaryRows,
                targetRows,
                matches,
                categoryRows: await evasionRateCategoryRepo.find(),
              }
            : null;

        return { matches: results, info };
      })
      .get('/legend-grid', async ({ query, set, headers }) => {
        const parsed = legendGridQuerySchema.safeParse(query);
        if (!parsed.success) {
          set.status = 400;
          return zodErrorResponse(parsed.error);
        }
        const { level, matchColumnIndex, matchLineOffset, matchEvasionRate } = parsed.data;
        const locale = parseAcceptLanguage(headers['accept-language']);

        let anntenaCategory = parsed.data.anntenaCategory;
        if (anntenaCategory === undefined) {
          anntenaCategory = await resolveAntennaCategory(parsed.data.antenna!, locale);
        }

        const evasionRateResolved = await resolve('evasionRate');
        const hpResolved = await resolve('hp');
        const [evasionRateRows, hpRows, categories] = await Promise.all([
          dataSource
            .getRepository(evasionRateResolved.entity)
            .find({ where: whereFor(evasionRateResolved, { level, anntenaCategory }) }),
          dataSource.getRepository(hpResolved.entity).find({ where: whereFor(hpResolved, { level, anntenaCategory }) }),
          evasionRateCategoryRepo.find(),
        ]);

        const grid = buildLegendGrid({
          categories: categories as unknown as PhysiqueEvasionRateCategoryRow[],
          evasionRateRows: evasionRateRows as unknown as TableRow[],
          hpRows: hpRows as unknown as TableRow[],
          matchColumnIndex,
          matchLineOffset,
          matchEvasionRate,
        });

        return {
          level,
          anntenaCategory,
          legendCells: grid.legendCells.map((cell) => ({
            ...cell,
            text: categoryTranslator.translatePhysique(cell.textKey, locale) ?? null,
          })),
          hpCells: grid.hpCells,
        };
      }),
  );
}
