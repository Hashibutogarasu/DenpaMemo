import type { EntityTarget, ObjectLiteral } from 'typeorm';
import { PhysiqueEvasionRateTableEntity } from '../../entities/physique-evasion-rate-table.entity';
import { PhysiqueTableEntity } from '../../entities/physique-table.entity';

/** Row shape every registered table type's entity must satisfy. */
export interface TableRowEntity extends ObjectLiteral {
  id: string;
  level: string;
  anntenaCategory: string;
  lineOffset: number;
  values: number[];
}

export interface TableEntityMapping<TEntity extends TableRowEntity = TableRowEntity> {
  readonly entity: EntityTarget<TEntity>;
  /** Set only for entities that multiplex several logical tables via one discriminator column. */
  readonly discriminator?: { column: string; value: string };
}

/**
 * The one part of a table type's definition that cannot live in the DB:
 * which TypeORM entity/repository backs it, and (for entities that
 * multiplex several logical tables via a discriminator column, like
 * `PhysiqueTableEntity.statusCategory`) which column/value selects this
 * type's rows. Column count and display label live in
 * `TableDefinitionEntity` (`table_definition`), seeded from
 * `data/table_definitions.json` — see `src/routes/tables.route.ts`'s
 * `resolveTableType`, which needs both this map and that table to fully
 * resolve a `type`. Adding a brand-new physical table only needs a new
 * line here (plus a matching `table_definitions.json` entry) — never a
 * new route file.
 */
export const TABLE_ENTITY_MAPPING: Record<string, TableEntityMapping<any>> = {
  hp: { entity: PhysiqueTableEntity, discriminator: { column: 'statusCategory', value: 'HP' } },
  speed: { entity: PhysiqueTableEntity, discriminator: { column: 'statusCategory', value: 'すばやさ' } },
  evasionRate: { entity: PhysiqueEvasionRateTableEntity },
};
