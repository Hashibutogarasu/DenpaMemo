import { Column, Entity, PrimaryColumn } from 'typeorm';

/**
 * Normalizes attribute categories (previously only implicit in which
 * `assets/data/attributes/{elemental,special}/` directory a JSON file
 * lived in, with no field of its own — the Dart loader derived
 * `isElemental` from the directory name) into a small numeric-coded
 * lookup table.
 */
@Entity('attribute_category')
export class AttributeCategoryEntity {
  @PrimaryColumn({ type: 'smallint' })
  code!: number;

  @Column({ type: 'varchar', unique: true })
  name!: string;
}

export const ATTRIBUTE_CATEGORY_SEED_ROWS: ReadonlyArray<{ code: number; name: string }> = [
  { code: 0, name: 'elemental' },
  { code: 1, name: 'special' },
];
