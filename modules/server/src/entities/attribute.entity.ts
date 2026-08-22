import {
  Column,
  Entity,
  JoinColumn,
  JoinTable,
  ManyToMany,
  ManyToOne,
} from 'typeorm';
import { BaseEntity } from './base.entity';
import { AttributeCategoryEntity } from './attribute-category.entity';

/** Ports `lib/domain/master_data/attribute.dart`. */
@Entity('attribute')
export class AttributeEntity extends BaseEntity {
  @Column({ type: 'int' })
  index!: number;

  @ManyToOne(() => AttributeCategoryEntity, { eager: true, nullable: false })
  @JoinColumn({ name: 'categoryId', referencedColumnName: 'code' })
  category!: AttributeCategoryEntity;

  @Column({ type: 'smallint' })
  categoryId!: number;

  @ManyToMany(() => AttributeEntity)
  @JoinTable({
    name: 'attribute_resistant_to',
    joinColumn: { name: 'attributeId', referencedColumnName: 'id' },
    inverseJoinColumn: { name: 'resistantToId', referencedColumnName: 'id' },
  })
  resistantTo!: AttributeEntity[];

  @ManyToMany(() => AttributeEntity)
  @JoinTable({
    name: 'attribute_weak_to',
    joinColumn: { name: 'attributeId', referencedColumnName: 'id' },
    inverseJoinColumn: { name: 'weakToId', referencedColumnName: 'id' },
  })
  weakTo!: AttributeEntity[];
}
