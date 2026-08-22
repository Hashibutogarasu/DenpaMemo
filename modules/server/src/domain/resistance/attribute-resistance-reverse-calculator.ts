import { calculateAttributeResistance } from './attribute-resistance-calculator';
import type { AttributeResistance, BodyColorSelection, ResistanceMasterData } from './types';

/**
 * Ports `AttributeResistanceReverseLookup.findColorCombination` from
 * `lib/domain/denpa_men/attribute_resistance_reverse_calculator.dart`.
 * Searches for a single body color (with or without SP), a same-color
 * pair, or a distinct-color pair whose calculated attribute resistance
 * matches `target` exactly. Returns the first match, or `null`.
 */
export function findColorCombination(
  target: AttributeResistance[],
  masterData: ResistanceMasterData,
): BodyColorSelection | null {
  const targetMap = toMap(target);
  const colorIds = masterData.bodyColorResistanceRules.map((rule) => rule.colorId);

  const candidates: BodyColorSelection[] = [
    ...colorIds.map((colorId): BodyColorSelection => ({ bodyColors: [colorId], isSpColor: false })),
    ...colorIds.map((colorId): BodyColorSelection => ({ bodyColors: [colorId], isSpColor: true })),
    ...colorIds.map((colorId): BodyColorSelection => ({ bodyColors: [colorId, colorId], isSpColor: false })),
  ];
  for (let i = 0; i < colorIds.length; i++) {
    for (let j = i + 1; j < colorIds.length; j++) {
      candidates.push({ bodyColors: [colorIds[i], colorIds[j]], isSpColor: false });
    }
  }

  for (const candidate of candidates) {
    const result = calculateAttributeResistance(candidate, masterData);
    if (mapEquals(toMap(result), targetMap)) {
      return candidate;
    }
  }

  return null;
}

function toMap(list: AttributeResistance[]): Map<string, number> {
  return new Map(list.map((resistance) => [resistance.attributeId, resistance.value]));
}

function mapEquals(a: Map<string, number>, b: Map<string, number>): boolean {
  if (a.size !== b.size) return false;
  for (const [key, value] of a) {
    if (b.get(key) !== value) return false;
  }
  return true;
}
