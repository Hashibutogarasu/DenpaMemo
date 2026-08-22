import type {
  AbnormalityResistance,
  BodyColorSelection,
  ResistanceMasterData,
} from './types';

/**
 * Ports `ColorAbnormalityResistanceCalculation.calculateColorAbnormalityResistance`
 * from `lib/domain/denpa_men/color_abnormality_resistance_calculator.dart`.
 * Every color's own bonus is simply summed: a same-color pair adds its
 * bonus twice, and distinct colors are never halved or reduced (unlike
 * attribute resistance).
 */
export function calculateColorAbnormalityResistance(
  selection: BodyColorSelection,
  masterData: ResistanceMasterData,
): AbnormalityResistance[] {
  const rulesByColorId = new Map(
    masterData.bodyColorAbnormalityResistanceRules.map((rule) => [rule.colorId, rule]),
  );

  const totals = new Map<string, number>();
  for (const colorId of selection.bodyColors) {
    const rule = rulesByColorId.get(colorId);
    if (!rule) continue;
    for (const [abnormalityId, bonus] of Object.entries(rule.abnormalityResistanceBonuses)) {
      totals.set(abnormalityId, (totals.get(abnormalityId) ?? 0) + bonus);
    }
  }

  return [...totals.entries()].map(([abnormalityId, value]) => ({ abnormalityId, value }));
}
