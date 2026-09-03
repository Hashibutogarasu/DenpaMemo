import { PhysiqueEvasionRateTableEntity } from '../../entities/physique-evasion-rate-table.entity';
import { PhysiqueTableEntity } from '../../entities/physique-table.entity';
import type { TableEntityMapping } from '../../types/tables/table';

/**
 * The physique domain's table type registry: which entity/discriminator
 * backs each registered `type`. Column count and display label live in
 * `TableDefinitionEntity` (`table_definition`), seeded from
 * `data/table_definitions.json` — see
 * `src/domain/tables/table-operations.ts`'s `resolveTableType`, which
 * needs both this map and that table to fully resolve a `type`. Adding a
 * brand-new physique table only needs a new line here (plus a matching
 * `table_definitions.json` entry) — never a new route file.
 */
export const TABLE_ENTITY_MAPPING: Record<string, TableEntityMapping<any>> = {
  hp: { entity: PhysiqueTableEntity, discriminator: { column: 'statusCategory', value: 'HP' } },
  speed: { entity: PhysiqueTableEntity, discriminator: { column: 'statusCategory', value: 'すばやさ' } },
  evasionRate: { entity: PhysiqueEvasionRateTableEntity },
};
