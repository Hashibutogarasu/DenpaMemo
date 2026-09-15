import type { Correction } from './types';

export { correctionsStatBonus } from '../resistance/rust-resistance-calculator';

/** Sums abnormality-resistance bonuses while the Rust API is extended for them. */
export function correctionsAbnormalityResistanceBonuses(
  corrections: Array<Correction & { abnormalityResistanceBonuses: Record<string, number> }>,
): Record<string, number> {
  const totals: Record<string, number> = {};
  for (const correction of corrections) {
    for (const [abnormalityId, bonus] of Object.entries(correction.abnormalityResistanceBonuses)) {
      totals[abnormalityId] = (totals[abnormalityId] ?? 0) + bonus;
    }
  }
  return totals;
}
