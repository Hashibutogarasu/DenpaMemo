import { BeforeInsert, Column, Entity, PrimaryColumn } from 'typeorm';
import { createId } from '@paralleldrive/cuid2';

/**
 * Isolated from master data (see `resolveMonsters`, not
 * `resolveMasterData`): does not extend `BaseEntity`, since `legacyId` is
 * specifically the master-data seed loaders' concept. `translateKey` is
 * Monster's own equivalent — the id used to look up its display string in
 * the `translation` table.
 */
@Entity('monsters')
export class MonsterEntity {
  @PrimaryColumn({ type: 'varchar', length: 24 })
  id!: string;

  @Column({ type: 'varchar', unique: true })
  translateKey!: string;

  @BeforeInsert()
  generateId() {
    if (!this.id) {
      this.id = createId();
    }
  }
}
