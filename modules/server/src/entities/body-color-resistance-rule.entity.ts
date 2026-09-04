import { Entity } from 'typeorm';
import { BaseEntity } from './base.entity';

/**
 * Ports `lib/domain/master_data/body_color_resistance_rule.dart`.
 * `id` holds the colorId (the JSON's object key). Its
 * `attributeResistanceBonuses` list is stored as `AttributeBonusEntity`
 * rows (`ownerType='body_color_resistance_rule'`), not a column.
 */
@Entity('body_color_resistance_rule')
export class BodyColorResistanceRuleEntity extends BaseEntity {}
