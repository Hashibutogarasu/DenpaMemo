import { Column, Entity, PrimaryColumn } from 'typeorm';

/**
 * Normalizes the "solo" (single target) vs "all" (targets everyone)
 * distinction that legacy antenna ids encode redundantly as a literal
 * substring (e.g. `heal_solo_1`, `heal_all_1`) on top of the already
 * meaningful `targetCount`/`targetsAll` fields. Seeded with two fixed
 * rows; `code` is the number `AnntenaEntity.targetModeId` references.
 */
@Entity('target_mode')
export class TargetModeEntity {
  @PrimaryColumn({ type: 'smallint' })
  code!: number;

  @Column({ type: 'varchar', unique: true })
  name!: string;
}

export const TARGET_MODE_SEED_ROWS: ReadonlyArray<{ code: number; name: string }> = [
  { code: 0, name: 'solo' },
  { code: 1, name: 'all' },
];
