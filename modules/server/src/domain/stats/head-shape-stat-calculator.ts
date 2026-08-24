import type { DenpaMenStatBonus, HeadShapeStatBonuses } from './types';

/** Ports `DenpaMenHeadShapeStatCalculation.headShapeStatBonus` from `denpa_men_head_shape_stat_calculator.dart`. */
export function headShapeStatBonus(headShape: HeadShapeStatBonuses): DenpaMenStatBonus {
  return {
    hp: headShape.hpBonus,
    ap: headShape.apBonus,
    attack: headShape.attackBonus,
    defense: headShape.defenseBonus,
    speed: headShape.speedBonus,
    evasionRate: headShape.evasionRateBonus,
  };
}
