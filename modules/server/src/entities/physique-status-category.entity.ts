import { createId } from '@paralleldrive/cuid2';
import { BeforeInsert, Column, Entity, PrimaryColumn } from 'typeorm';

/**
 * Status category a physique table belongs to (e.g. HP, speed), each with
 * its own row width (`columnCount`) — HP and speed tables don't have the
 * same number of growth stages. Seeded once at boot like
 * `PhysiqueAntennaCategoryEntity`, and exposed read-only via
 * `MasterData.physiqueStatusCategories` so the Flutter app never
 * hardcodes a table's column count. Does not extend `BaseEntity`:
 * `legacyId` is specifically the master-data seed loaders' concept, and
 * `name` is this entity's own unique key.
 */
@Entity('physique_status_category')
export class PhysiqueStatusCategoryEntity {
  @PrimaryColumn({ type: 'varchar', length: 24 })
  id!: string;

  @Column({ type: 'varchar', unique: true })
  name!: string;

  @Column({ type: 'int' })
  columnCount!: number;

  @BeforeInsert()
  generateId() {
    if (!this.id) {
      this.id = createId();
    }
  }
}
