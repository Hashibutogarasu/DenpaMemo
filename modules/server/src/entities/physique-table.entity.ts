import { createId } from '@paralleldrive/cuid2';
import { BeforeInsert, Column, Entity, Index, PrimaryColumn } from 'typeorm';
import type { TableValues } from '../types/tables/table';

/**
 * One row of a physique table: the growth values for a specific antenna
 * category and status category (e.g. HP, speed — see
 * `PhysiqueStatusCategoryEntity`) at a specific physique level. Rows are
 * created entirely through the `/physiques` REST endpoints (see
 * `src/routes/physiques.route.ts`) — unlike the rest of
 * `modules/server`'s master data, there is no default JSON seed for this
 * entity. Does not extend `BaseEntity`: `legacyId` is specifically the
 * master-data seed loaders' concept. `values`' length is validated against
 * its status category's `columnCount` at the route layer, not enforced
 * here — different status categories have different row widths.
 */
@Entity('physique_table')
@Index(['statusCategory', 'level', 'anntenaCategory', 'lineOffset'], { unique: true })
export class PhysiqueTableEntity {
  @PrimaryColumn({ type: 'varchar', length: 24 })
  id!: string;

  @Column({ type: 'varchar', default: 'HP' })
  statusCategory!: string;

  @Column({ type: 'varchar' })
  level!: string;

  @Column({ type: 'varchar' })
  anntenaCategory!: string;

  @Column({ type: 'int' })
  lineOffset!: number;

  @Column({ type: 'jsonb' })
  values!: TableValues;

  @BeforeInsert()
  generateId() {
    if (!this.id) {
      this.id = createId();
    }
  }
}
