import { createId } from '@paralleldrive/cuid2';
import { BeforeInsert, Column, Entity, Index, PrimaryColumn } from 'typeorm';

/** Number of value columns a physique table row holds. */
export const PHYSIQUE_TABLE_COLUMN_COUNT = 10;

/**
 * One row of a physique table: the growth values for a specific antenna
 * category at a specific physique level. Rows are created entirely
 * through the `/physiques` REST endpoints (see
 * `src/routes/physiques.route.ts`) — unlike the rest of
 * `modules/server`'s master data, there is no default JSON seed for this
 * entity. Does not extend `BaseEntity`: `legacyId` is specifically the
 * master-data seed loaders' concept.
 */
@Entity('physique_table')
@Index(['level', 'anntenaCategory', 'lineOffset'], { unique: true })
export class PhysiqueTableEntity {
  @PrimaryColumn({ type: 'varchar', length: 24 })
  id!: string;

  @Column({ type: 'varchar' })
  level!: string;

  @Column({ type: 'varchar' })
  anntenaCategory!: string;

  @Column({ type: 'int' })
  lineOffset!: number;

  @Column({ type: 'jsonb' })
  values!: number[];

  @BeforeInsert()
  generateId() {
    if (!this.id) {
      this.id = createId();
    }
  }
}
