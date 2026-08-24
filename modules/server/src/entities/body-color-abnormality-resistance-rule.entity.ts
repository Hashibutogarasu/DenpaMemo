import { Column, Entity } from 'typeorm';
import { BaseEntity } from './base.entity';

/**
 * Ports `lib/domain/master_data/body_color_abnormality_resistance_rule.dart`.
 * `legacyId` holds the colorId (the JSON's object key).
 */
@Entity('body_color_abnormality_resistance_rule')
export class BodyColorAbnormalityResistanceRuleEntity extends BaseEntity {
  @Column({ type: 'jsonb', default: {} })
  abnormalityResistanceBonuses!: Record<string, number>;
}
