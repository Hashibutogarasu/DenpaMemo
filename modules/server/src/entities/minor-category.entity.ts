import { Column, Entity, JoinColumn, ManyToOne, PrimaryColumn } from 'typeorm';
import { MajorCategoryEntity } from './major-category.entity';
import { PhysiqueAntennaCategoryEntity } from './physique-antenna-category.entity';

/**
 * A physique antenna category's minor grouping (e.g. "heal_solo",
 * "attack_all"), identified purely by an English-word id. Carries no
 * translated string — display text is resolved through the server's
 * `i18n` package (see `src/i18n/i18n.ts`), keyed by this `id`.
 * `physiqueAntennaCategory` only bridges to the legacy Japanese-keyed
 * `PhysiqueAntennaCategoryEntity` so `/tables?category=` keeps working;
 * it must never be used to resolve display text.
 */
@Entity('minor_category')
export class MinorCategoryEntity {
  @PrimaryColumn({ type: 'varchar' })
  id!: string;

  @ManyToOne(() => MajorCategoryEntity, { eager: true, nullable: false })
  @JoinColumn({ name: 'majorCategoryId' })
  majorCategory!: MajorCategoryEntity;

  @Column({ type: 'varchar' })
  majorCategoryId!: string;

  @ManyToOne(() => PhysiqueAntennaCategoryEntity, { eager: true, nullable: false })
  @JoinColumn({ name: 'physiqueAntennaCategoryId' })
  physiqueAntennaCategory!: PhysiqueAntennaCategoryEntity;

  @Column({ type: 'varchar', length: 24 })
  physiqueAntennaCategoryId!: string;
}
