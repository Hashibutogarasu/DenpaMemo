import {
  Column,
  Entity,
  JoinColumn,
  JoinTable,
  ManyToMany,
  ManyToOne,
} from 'typeorm';
import { BaseEntity } from './base.entity';
import { AntennaCategoryEntity } from './antenna-category.entity';
import { TargetModeEntity } from './target-mode.entity';
import { AttributeEntity } from './attribute.entity';

/**
 * Ports `lib/domain/master_data/anntena.dart`. `targetsAll` is not a
 * column here: it is folded into `targetMode` (see
 * `TargetModeEntity`), which also absorbs the "solo" distinction that
 * legacy JSON only expressed as an `_solo_`/`_all_` substring in `id`.
 */
@Entity('anntena')
export class AnntenaEntity extends BaseEntity {
  @ManyToOne(() => AntennaCategoryEntity, { eager: true, nullable: false })
  @JoinColumn({ name: 'categoryId', referencedColumnName: 'code' })
  category!: AntennaCategoryEntity;

  @Column({ type: 'smallint' })
  categoryId!: number;

  @Column({ type: 'int', nullable: true })
  targetCount!: number | null;

  @ManyToOne(() => TargetModeEntity, { eager: true, nullable: true })
  @JoinColumn({ name: 'targetModeId', referencedColumnName: 'code' })
  targetMode!: TargetModeEntity | null;

  @Column({ type: 'smallint', nullable: true })
  targetModeId!: number | null;

  @Column({ type: 'boolean', default: false })
  dealsDamage!: boolean;

  @ManyToMany(() => AttributeEntity, { eager: true })
  @JoinTable({
    name: 'anntena_attack_attribute',
    joinColumn: { name: 'anntenaId', referencedColumnName: 'id' },
    inverseJoinColumn: { name: 'attributeId', referencedColumnName: 'id' },
  })
  attackAttributes!: AttributeEntity[];

  @Column({ type: 'boolean', default: false })
  isInheritable!: boolean;

  @ManyToOne(() => AnntenaEntity, { nullable: true })
  @JoinColumn({ name: 'evolvesToId', referencedColumnName: 'id' })
  evolvesTo!: AnntenaEntity | null;

  @Column({ type: 'varchar', length: 24, nullable: true })
  evolvesToId!: string | null;

  @Column({ type: 'int', nullable: true })
  maxLevel!: number | null;

  @Column({ type: 'varchar', nullable: true })
  variantGroupId!: string | null;

  @Column({ type: 'boolean', default: true })
  hasLevel!: boolean;
}
