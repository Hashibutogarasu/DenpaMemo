import { createId } from '@paralleldrive/cuid2';
import { BeforeInsert, Column, Entity, Index, PrimaryColumn } from 'typeorm';

/**
 * One row of a physique table: the growth values for a specific antenna
 * category at a specific physique level. Rows are created entirely
 * through the `/physiques` REST endpoints (see
 * `src/routes/physiques.route.ts`) — unlike the rest of
 * `modules/server`'s master data, there is no default JSON seed for this
 * entity. Does not extend `BaseEntity`: `legacyId` is specifically the
 * master-data seed loaders' concept. `values` has no fixed length: the
 * number of columns a table has is whatever length its rows were written
 * with, not a shared constant enforced here.
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
