import { calculateAttributeResistance } from './attribute-resistance-calculator';
import { calculateColorAbnormalityResistance } from './color-abnormality-resistance-calculator';
import type {
  BodyColorSelection,
  DenpaMenResistances,
  HeadShapeResistanceBonuses,
  ResistanceMasterData,
} from './types';

/**
 * Ports `DenpaMenResistanceCalculation.calculateResistances` from
 * `lib/domain/denpa_men/denpa_men_resistance_calculator.dart`. Unlike the
 * Dart original (an extension method on `DenpaMen`), this takes the body
 * color selection and head shape bonuses as plain arguments, since the
 * server has no `DenpaMen`-equivalent entity — individual data stays
 * client-side in ObjectBox.
 */
export function calculateDenpaMenResistances(
  colorSelection: BodyColorSelection,
  headShape: HeadShapeResistanceBonuses,
  masterData: ResistanceMasterData,
): DenpaMenResistances {
  const abnormalityTotals = new Map<string, number>();
  for (const resistance of calculateColorAbnormalityResistance(colorSelection, masterData)) {
    abnormalityTotals.set(resistance.abnormalityId, resistance.value);
  }
  const attributeTotals = new Map<string, number>();
  for (const resistance of calculateAttributeResistance(colorSelection, masterData)) {
    attributeTotals.set(resistance.attributeId, resistance.value);
  }

  for (const [abnormalityId, bonus] of Object.entries(headShape.abnormalityResistanceBonuses)) {
    abnormalityTotals.set(abnormalityId, (abnormalityTotals.get(abnormalityId) ?? 0) + bonus);
  }
  for (const bonus of headShape.attributeResistanceBonuses) {
    attributeTotals.set(bonus.attributeId, (attributeTotals.get(bonus.attributeId) ?? 0) + bonus.bonus);
  }

  const attributeIndexById = new Map(masterData.attributes.map((attribute) => [attribute.id, attribute.index]));

  const abnormalityResistances = [...abnormalityTotals.entries()]
    .filter(([, value]) => value !== 0)
    .map(([abnormalityId, value]) => ({ abnormalityId, value }));

  const attributeResistance = [...attributeTotals.entries()]
    .filter(([, value]) => value !== 0)
    .map(([attributeId, value]) => ({ attributeId, value }))
    .sort(
      (a, b) => (attributeIndexById.get(a.attributeId) ?? 0) - (attributeIndexById.get(b.attributeId) ?? 0),
    );

  return { abnormalityResistances, attributeResistance };
}
