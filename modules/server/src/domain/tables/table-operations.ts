import type { DataSource } from 'typeorm';
import { TableDefinitionEntity } from '../../entities/table-definition.entity';
import type { TableEntityMapping } from './table-types';

export interface ResolvedTableType extends TableEntityMapping {
  columnCount: number;
}

export interface TableRow {
  id: string;
  level: string;
  anntenaCategory: string;
  lineOffset: number;
  values: number[];
}

/**
 * Resolves a `type` into everything needed to operate on it: row width
 * from the DB-driven `TableDefinitionEntity` (shared by every domain's
 * table registry, seeded from its own `data/*.json`), and the
 * entity/discriminator from the given domain-specific `registry` (e.g.
 * `src/domain/physique/table-registry.ts`'s `TABLE_ENTITY_MAPPING`).
 * `undefined` if either half is missing — i.e. an unregistered type.
 */
export async function resolveTableType(
  dataSource: DataSource,
  type: string,
  registry: Record<string, TableEntityMapping>,
): Promise<ResolvedTableType | undefined> {
  const definition = await dataSource.getRepository(TableDefinitionEntity).findOne({ where: { type } });
  const mapping = registry[type];
  if (!definition || !mapping) {
    return undefined;
  }
  return { columnCount: definition.columnCount, ...mapping };
}

export function whereFor(resolved: TableEntityMapping, filters: { level?: string; anntenaCategory?: string }) {
  const where: Record<string, unknown> = {};
  if (resolved.discriminator) {
    where[resolved.discriminator.column] = resolved.discriminator.value;
  }
  if (filters.level !== undefined) where.level = filters.level;
  if (filters.anntenaCategory !== undefined) where.anntenaCategory = filters.anntenaCategory;
  return where;
}

/**
 * Normalizes a saved/fetched row into the wire shape callers actually see:
 * `type` instead of whatever (if any) discriminator column the backing
 * entity happens to store it under. Callers never send or see a
 * discriminator column name directly. `values` is clamped to
 * `columnCount` so older rows stored before a type's column count was
 * narrowed never expose more values than the type currently declares —
 * every caller sees the same, currently-valid row width without having
 * to enforce it themselves.
 */
export function serializeRow(type: string, columnCount: number, row: TableRow) {
  return {
    id: row.id,
    type,
    level: row.level,
    anntenaCategory: row.anntenaCategory,
    lineOffset: row.lineOffset,
    values: row.values.length > columnCount ? row.values.slice(0, columnCount) : row.values,
  };
}

/**
 * Deletes the rows at `lineOffsets` within one type's `level`/
 * `anntenaCategory` group, then re-sequences the remaining rows'
 * `lineOffset`s back to a contiguous `0..n-1` range so a row-range `PUT`
 * (which indexes into the table by array position) stays gap-free after
 * a delete.
 */
export async function deleteTableRows(
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
