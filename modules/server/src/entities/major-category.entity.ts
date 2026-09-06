import { Entity, PrimaryColumn } from 'typeorm';

/**
 * A physique antenna category's major grouping (e.g. "healing", "attack"),
 * identified purely by an English-word id. Carries no translated string —
 * display text is resolved through the server's `i18n` package (see
 * `src/i18n/i18n.ts`), keyed by this `id`.
 */
@Entity('major_category')
export class MajorCategoryEntity {
  @PrimaryColumn({ type: 'varchar' })
  id!: string;
}
