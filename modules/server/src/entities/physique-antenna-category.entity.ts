import { createId } from '@paralleldrive/cuid2';
import { BeforeInsert, Column, Entity, PrimaryColumn } from 'typeorm';

/**
 * Default category-to-antenna grouping for physique table rows (see
 * `data/physique_antenna_categories.json`), seeded once at boot like the
 * rest of `modules/server`'s master data. Exposed read-only via
 * `MasterData.physiqueAntennaCategories` so the Flutter app can build its
 * category/antenna pickers before writing to `/physiques`. Does not
 * extend `BaseEntity`: `legacyId` is specifically the master-data seed
 * loaders' concept, and `anntenaCategory` is this entity's own unique key.
 */
@Entity('physique_antenna_category')
export class PhysiqueAntennaCategoryEntity {
  @PrimaryColumn({ type: 'varchar', length: 24 })
  id!: string;

  @Column({ type: 'varchar' })
  category!: string;

  @Column({ type: 'varchar', unique: true })
  anntenaCategory!: string;

  @BeforeInsert()
  generateId() {
    if (!this.id) {
      this.id = createId();
    }
  }
}
