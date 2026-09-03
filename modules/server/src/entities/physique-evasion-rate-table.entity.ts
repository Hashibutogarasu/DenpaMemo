import { createId } from '@paralleldrive/cuid2';
import { BeforeInsert, Column, Entity, Index, PrimaryColumn } from 'typeorm';

/**
 * One row of the evasion-rate table: independent from `physique_table` —
 * not a `statusCategory` within it — since evasion rate has no other
 * category to be mixed with. `values`' column positions line up 1:1 with
 * `physique_table`'s `HP` rows (same `columnCount`, from
 * `PhysiqueStatusCategoryEntity`) so a search can cross-reference the two
 * tables by matching `(level, anntenaCategory, lineOffset)` and comparing
 * values at the same array index — see
 * `src/domain/physique/evasion-rate-search.ts`. This task only adds the
 * search endpoint; there is no write API yet, so rows must currently be
 * inserted directly against this table.
 */
@Entity('physique_evasion_rate_table')
@Index(['level', 'anntenaCategory', 'lineOffset'], { unique: true })
export class PhysiqueEvasionRateTableEntity {
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
