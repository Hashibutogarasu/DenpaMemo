import type { EntityTarget, ObjectLiteral } from 'typeorm';

/** Row shape every registered table type's entity must satisfy. */
export interface TableRowEntity extends ObjectLiteral {
  id: string;
  level: string;
  anntenaCategory: string;
  lineOffset: number;
  values: number[];
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
