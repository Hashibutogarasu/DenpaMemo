import { Column, Entity } from 'typeorm';
import { BaseEntity } from './base.entity';

/** Ports `lib/domain/master_data/correction.dart`. */
@Entity('correction')
export class CorrectionEntity extends BaseEntity {
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

  @Column({ type: 'jsonb', default: {} })
  abnormalityResistanceBonuses!: Record<string, number>;
}
