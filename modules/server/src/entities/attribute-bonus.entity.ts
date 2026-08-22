import { Column, Entity, ManyToOne, PrimaryGeneratedColumn } from 'typeorm';
import { AttributeEntity } from './attribute.entity';

/**
 * Generic `{ownerType, ownerId} -> {attribute, bonus}` row, shared by
 * every master-data entity that has an `attributeResistanceBonuses`
 * list in Dart (`HeadShape`, `BodyColorResistanceRule`) instead of a
 * dedicated join table per owner. Ports the `AttributeBonus` typedef
 * record from `lib/domain/master_data/attribute_bonus.dart`.
 */
export type AttributeBonusOwnerType = 'head_shape' | 'body_color_resistance_rule';

@Entity('attribute_bonus')
export class AttributeBonusEntity {
  @PrimaryGeneratedColumn('uuid')
  id!: string;

  @Column({ type: 'varchar' })
  ownerType!: AttributeBonusOwnerType;

  @Column({ type: 'varchar', length: 24 })
  ownerId!: string;

  @ManyToOne(() => AttributeEntity, { eager: true, nullable: false })
  attribute!: AttributeEntity;

  @Column({ type: 'int' })
  bonus!: number;
}
