import { Column, Entity, Index, PrimaryGeneratedColumn } from 'typeorm';

/**
 * Ports the ID → display-string maps from `lib/i18n/ja.i18n.json`
 * (`slang.yaml`'s `maps:` entries: headShape / antenna / bodyColor /
 * attribute / abnormality / correction). `personality` / `pattern` /
 * `physique` are intentionally excluded — they have no translation map
 * in the current app either.
 */
export type TranslationEntityType =
  | 'headShape'
  | 'antenna'
  | 'bodyColor'
  | 'attribute'
  | 'abnormality'
  | 'correction'
  | 'monster';

@Entity('translation')
@Index(['entityType', 'entityLegacyId', 'locale'], { unique: true })
export class TranslationEntity {
  @PrimaryGeneratedColumn('uuid')
  id!: string;

  @Column({ type: 'varchar' })
  entityType!: TranslationEntityType;

  @Column({ type: 'varchar' })
  entityLegacyId!: string;

  @Column({ type: 'varchar' })
  locale!: string;

  @Column({ type: 'text' })
  value!: string;
}
