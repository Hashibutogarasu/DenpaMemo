import type { Correction, DenpaMenStatBonus } from './types';

/**
 * Ports `DenpaMenCorrectionCalculation.correctionsStatBonus` from
 * `lib/domain/denpa_men/denpa_men_correction_calculator.dart` — the pure
 * summation of `corrections`' growth-stat bonuses. Applying the result on
 * top of an individual's base stats (`applyCorrections`) stays in Dart,
 * since it operates on the client-only `DenpaMen` entity.
 */
export function correctionsStatBonus(corrections: Correction[]): DenpaMenStatBonus {
  let hp = 0;
  let ap = 0;
  let attack = 0;
  let defense = 0;
  let speed = 0;
  let evasionRate = 0;

  for (const correction of corrections) {
    hp += correction.hpBonus;
    ap += correction.apBonus;
    attack += correction.attackBonus;
    defense += correction.defenseBonus;
    speed += correction.speedBonus;
    evasionRate += correction.evasionRateBonus;
  }

  return { hp, ap, attack, defense, speed, evasionRate };
}

/**
 * Ports the abnormality-resistance-bonus summation embedded in
 * `DenpaMenCorrectionCalculation.applyCorrections`.
 */
export function correctionsAbnormalityResistanceBonuses(
  corrections: Array<{ abnormalityResistanceBonuses: Record<string, number> }>,
): Record<string, number> {
  const totals: Record<string, number> = {};
  for (const correction of corrections) {
    for (const [abnormalityId, bonus] of Object.entries(correction.abnormalityResistanceBonuses)) {
      totals[abnormalityId] = (totals[abnormalityId] ?? 0) + bonus;
    }
  }
  return totals;
}
