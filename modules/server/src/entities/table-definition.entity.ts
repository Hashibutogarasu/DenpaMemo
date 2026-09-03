import { createId } from '@paralleldrive/cuid2';
import { BeforeInsert, Column, Entity, PrimaryColumn } from 'typeorm';

/**
 * DB-driven metadata for one registered "table type" operated on through
 * `/tables` (see `src/routes/tables.route.ts`): its row width
 * (`columnCount`) and a display-label translation key. Seeded from
 * `data/table_definitions.json` at boot, like
 * `PhysiqueStatusCategoryEntity`. Which TypeORM entity/discriminator a
 * `type` actually maps to cannot live here — see
 * `src/domain/physique/table-registry.ts` for that (necessarily
 * code-level) half of a table type's definition.
 */
@Entity('table_definition')
export class TableDefinitionEntity {
  @PrimaryColumn({ type: 'varchar', length: 24 })
  id!: string;

  @Column({ type: 'varchar', unique: true })
  type!: string;

  @Column({ type: 'int' })
  columnCount!: number;

  @Column({ type: 'varchar' })
  translationKey!: string;

  @BeforeInsert()
  generateId() {
    if (!this.id) {
      this.id = createId();
    }
  }
}
