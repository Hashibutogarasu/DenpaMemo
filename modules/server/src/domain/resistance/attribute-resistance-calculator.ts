import type {
  AttributeBonus,
  AttributeResistance,
  BodyColorSelection,
  ResistanceMasterData,
} from './types';

/**
 * Ports `AttributeResistanceCalculation.calculateAttributeResistance` from
 * `lib/domain/denpa_men/attribute_resistance_calculator.dart`. This is the
 * highest-risk port in the whole migration: branch order, SP-color rules,
 * same-color-pair rules, and distinct-pair halving must match exactly.
 *
 * Distinct-pair halving uses `Math.trunc` (truncate toward zero), matching
 * Dart's `~/` operator — NOT `Math.floor`, which rounds toward negative
 * infinity and would give a different result for negative bonuses.
 */
export function calculateAttributeResistance(
  selection: BodyColorSelection,
  masterData: ResistanceMasterData,
): AttributeResistance[] {
  const rulesByColorId = new Map(
    masterData.bodyColorResistanceRules.map((rule) => [rule.colorId, rule]),
  );
  const ruleForColor = selection.bodyColors.map((colorId) => {
    const rule = rulesByColorId.get(colorId);
    if (!rule) {
      throw new Error(`No body color resistance rule for colorId "${colorId}"`);
    }
    return rule;
  });
  const attributeIdList = masterData.attributes
    .filter((attribute) => attribute.category === 'elemental')
    .map((attribute) => attribute.id);
  const attributeById = new Map(masterData.attributes.map((attribute) => [attribute.id, attribute]));

  const isSameColorPair =
    selection.bodyColors.length === 2 && selection.bodyColors[0] === selection.bodyColors[1];
  const isDistinctColorPair = selection.bodyColors.length === 2 && !isSameColorPair;
  const baseRule = isDistinctColorPair ? null : ruleForColor[0];

  const totals = new Map<string, number>();
  if (isDistinctColorPair) {
    for (const rule of ruleForColor) {
      for (const bonus of rule.attributeResistanceBonuses) {
        totals.set(bonus.attributeId, (totals.get(bonus.attributeId) ?? 0) + bonus.bonus);
      }
    }
  } else {
    for (const bonus of baseRule!.attributeResistanceBonuses) {
      totals.set(bonus.attributeId, bonus.bonus);
    }
  }

  if (baseRule !== null) {
    applySoloOrPairEffects({
      totals,
      ownBonuses: baseRule.attributeResistanceBonuses,
      attributeIdList,
      isSpColor: selection.isSpColor,
      isSameColorPair,
    });
  }

  if (isDistinctColorPair) {
    for (const [attributeId, value] of totals) {
      totals.set(attributeId, Math.trunc(value / 2));
    }
  }

  const result: AttributeResistance[] = [];
  for (const [attributeId, value] of totals) {
    if (value === 0) continue;
    if (!attributeById.has(attributeId)) {
      throw new Error(`Unknown attribute id "${attributeId}"`);
    }
    result.push({ attributeId, value });
  }
  return result;
}

function applySoloOrPairEffects({
  totals,
  ownBonuses,
  attributeIdList,
  isSpColor,
  isSameColorPair,
}: {
  totals: Map<string, number>;
  ownBonuses: AttributeBonus[];
  attributeIdList: string[];
  isSpColor: boolean;
  isSameColorPair: boolean;
}): void {
  if (ownBonuses.length === 0) {
    if (isSpColor) {
      for (const attributeId of attributeIdList) {
        totals.set(attributeId, (totals.get(attributeId) ?? 0) + 1);
      }
    }
    return;
  }

  const hasOwnStrength = ownBonuses.some((bonus) => bonus.bonus > 0);
  const isFullNegativeCoverage = !hasOwnStrength && ownBonuses.length === attributeIdList.length;

  if (isSpColor) {
    if (hasOwnStrength) {
      for (const [attributeId, value] of totals) {
        if (value < 0) totals.set(attributeId, 0);
      }
    } else if (isFullNegativeCoverage) {
      for (const attributeId of attributeIdList) {
        totals.set(attributeId, -1);
      }
    }
  } else if (isSameColorPair) {
    if (hasOwnStrength) {
      for (const [attributeId, value] of totals) {
        if (value > 0) totals.set(attributeId, value + 1);
        else if (value < 0) totals.set(attributeId, value - 1);
      }
    } else if (isFullNegativeCoverage) {
      for (const [attributeId, value] of totals) {
        totals.set(attributeId, value + 1);
      }
    }
  }
}
