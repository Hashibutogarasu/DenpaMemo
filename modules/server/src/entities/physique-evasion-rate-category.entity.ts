import { createId } from '@paralleldrive/cuid2';
import { BeforeInsert, Column, Entity, PrimaryColumn } from 'typeorm';

/**
 * One column-position pattern for translating an evasion-rate table's
 * `columnIndex` into a physique category (see
 * `src/domain/physique/physique-evasion-rate-category.ts`). Seeded from
 * `data/physique_evasion_rate_categories.xlsx`, a spreadsheet meant to be
 * hand-edited as the real column semantics get refined, rather than a
 * hardcoded lookup table in TypeScript. `sign` records which side of an
 * overlapping plus/minus pair this pattern belongs to, when the source
 * spreadsheet's cell named one (`null` otherwise).
 */
@Entity('physique_evasion_rate_category')
export class PhysiqueEvasionRateCategoryEntity {
  @PrimaryColumn({ type: 'varchar', length: 24 })
  id!: string;

  @Column({ type: 'int' })
  evasionRateStart!: number;

  @Column({ type: 'int' })
  evasionRateEnd!: number;

  @Column({ type: 'int' })
  columnIndex!: number;

  @Column({ type: 'varchar' })
  textKey!: string;

  @Column({ type: 'varchar', nullable: true })
  sign!: 'plus' | 'minus' | null;

  @Column({ type: 'varchar', nullable: true })
  note!: string | null;

  @BeforeInsert()
  generateId() {
    if (!this.id) {
      this.id = createId();
    }
  }
}
