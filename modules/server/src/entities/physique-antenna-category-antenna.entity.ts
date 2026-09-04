import { createId } from '@paralleldrive/cuid2';
import { BeforeInsert, Column, Entity, Index, JoinColumn, ManyToOne, PrimaryColumn } from 'typeorm';
import { AnntenaEntity } from './anntena.entity';
import { MinorCategoryEntity } from './minor-category.entity';

/**
 * Links one minor physique antenna category to one concrete antenna.
 * Neither `MinorCategoryEntity` nor `AnntenaEntity` carries this link
 * itself — it lives here, as its own seeded record, so the server stays
 * the single authority over which antennas belong to which category.
 * Does not extend `BaseEntity`: like `PhysiqueAntennaCategoryEntity`,
 * this entity has no JSON-authored `id` of its own.
 */
@Entity('physique_antenna_category_antenna')
@Index(['minorCategoryId', 'anntenaId'], { unique: true })
export class PhysiqueAntennaCategoryAntennaEntity {
  @PrimaryColumn({ type: 'varchar', length: 24 })
  id!: string;

  @ManyToOne(() => MinorCategoryEntity, { eager: true, nullable: false })
  @JoinColumn({ name: 'minorCategoryId' })
  minorCategory!: MinorCategoryEntity;

  @Column({ type: 'varchar' })
  minorCategoryId!: string;

  @ManyToOne(() => AnntenaEntity, { eager: true, nullable: false })
  @JoinColumn({ name: 'anntenaId' })
  anntena!: AnntenaEntity;

  @Column({ type: 'varchar', length: 24 })
  anntenaId!: string;

  @BeforeInsert()
  generateId() {
    if (!this.id) {
      this.id = createId();
    }
  }
}
