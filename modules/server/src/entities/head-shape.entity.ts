import { Column, Entity } from 'typeorm';
import { BaseEntity } from './base.entity';

/** Ports `lib/domain/master_data/head_shape.dart`. */
@Entity('head_shape')
export class HeadShapeEntity extends BaseEntity {
  @Column({ type: 'jsonb', default: {} })
  abnormalityResistanceBonuses!: Record<string, number>;

  @Column({ type: 'int', default: 0 })
  hpBonus!: number;

  @Column({ type: 'int', default: 0 })
  apBonus!: number;

  @Column({ type: 'int', default: 0 })
  attackBonus!: number;

  @Column({ type: 'int', default: 0 })
  defenseBonus!: number;

  @Column({ type: 'int', default: 0 })
  speedBonus!: number;

  @Column({ type: 'int', default: 0 })
  evasionRateBonus!: number;
}
