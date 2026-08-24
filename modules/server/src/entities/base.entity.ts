import { createId } from '@paralleldrive/cuid2';
import { BeforeInsert, Column, PrimaryColumn } from 'typeorm';

/**
 * Shared columns for every master-data entity: a cuid2 primary key
 * generated at insert time, plus the original JSON "id" string
 * (`legacyId`) that the seed loaders, GraphQL layer, and Flutter's
 * `fromJson` mapping key off of. `legacyId` carries a unique index per
 * table, which is the first line of defense against duplicate master
 * data ids (see `seed/duplicate-id-guard.ts` for the second).
 */
export abstract class BaseEntity {
  @PrimaryColumn({ type: 'varchar', length: 24 })
  id!: string;

  @Column({ type: 'varchar', unique: true })
  legacyId!: string;

  @BeforeInsert()
  generateId() {
    if (!this.id) {
      this.id = createId();
    }
  }
}
