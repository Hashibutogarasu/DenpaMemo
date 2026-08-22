import { Column, Entity, PrimaryColumn } from 'typeorm';

/**
 * Normalizes antenna categories (previously only expressed by which
 * `assets/data/antennas/{attack,support,other}/` directory a JSON file
 * lived in, duplicated as a string `category` field inside the JSON
 * itself) into a small numeric-coded lookup table.
 */
@Entity('antenna_category')
export class AntennaCategoryEntity {
  @PrimaryColumn({ type: 'smallint' })
  code!: number;

  @Column({ type: 'varchar', unique: true })
  name!: string;
}

export const ANTENNA_CATEGORY_SEED_ROWS: ReadonlyArray<{ code: number; name: string }> = [
  { code: 0, name: 'attack' },
  { code: 1, name: 'support' },
  { code: 2, name: 'other' },
];
