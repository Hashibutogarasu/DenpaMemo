import type { EntityTarget, ObjectLiteral } from 'typeorm';

/** A single cell in a table row's `values` array. Blank is `null`, never coerced to `0`. */
export type TableCellValue = number | null;

/** A table row's full `values` array, shared by every domain's table entities and routes. */
export type TableValues = TableCellValue[];

/** Row shape every registered table type's entity must satisfy. */
export interface TableRowEntity extends ObjectLiteral {
  id: string;
  level: string;
  anntenaCategory: string;
  lineOffset: number;
  values: TableValues;
}

/**
 * Domain-agnostic contract a "table type registry" entry must satisfy:
 * which TypeORM entity/repository backs it, and (for entities that
 * multiplex several logical tables via a discriminator column) which
 * column/value selects this type's rows. Any domain that wants its own
 * generic `/tables`-style REST resource defines its own
 * `Record<string, TableEntityMapping>` (see
 * `src/domain/physique/table-registry.ts` for the physique one) and hands
 * it to `src/domain/tables/table-operations.ts`'s functions — the
 * mechanics never need to be copy-pasted per domain.
 */
export interface TableEntityMapping<TEntity extends TableRowEntity = TableRowEntity> {
  readonly entity: EntityTarget<TEntity>;
  /** Set only for entities that multiplex several logical tables via one discriminator column. */
  readonly discriminator?: { column: string; value: string };
}
