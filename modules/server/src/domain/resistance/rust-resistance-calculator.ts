import {
  calculateAttributeResistance as calculateAttributeResistanceWithRust,
  calculateColorAbnormalityResistance as calculateColorAbnormalityResistanceWithRust,
  calculateCorrectionStatBonus as calculateCorrectionStatBonusWithRust,
  calculateDenpaMenResistances as calculateDenpaMenResistancesWithRust,
  findColorCombination as findColorCombinationWithRust,
} from 'denpamemo_logics';

import type {
  AbnormalityResistance,
  AttributeResistance,
  BodyColorSelection,
  DenpaMenResistances,
  HeadShapeResistanceBonuses,
  ResistanceMasterData,
} from './types';
import type { Correction, DenpaMenStatBonus } from '../stats/types';

type CorrectionWithAbnormalityBonuses = Correction & {
  abnormalityResistanceBonuses: Record<string, number>;
};

interface RustAttribute {
  id: string;
  index: number;
  isElemental: boolean;
}

interface RustResistanceMasterData {
  attributes: RustAttribute[];
  bodyColorResistanceRules: Array<{
    colorId: string;
    attributeResistanceBonuses: Array<{ attributeId: string; bonus: number }>;
  }>;
  bodyColorAbnormalityResistanceRules: Array<{
    colorId: string;
    abnormalityResistanceBonuses: Array<{ id: string; bonus: number }>;
  }>;
}

function toRustMasterData(masterData: ResistanceMasterData): RustResistanceMasterData {
  return {
    attributes: masterData.attributes.map((attribute) => ({
      id: attribute.id,
      index: attribute.index,
      isElemental: attribute.category === 'elemental',
    })),
    bodyColorResistanceRules: masterData.bodyColorResistanceRules.map((rule) => ({
      colorId: rule.colorId,
      attributeResistanceBonuses: rule.attributeResistanceBonuses,
    })),
    bodyColorAbnormalityResistanceRules: masterData.bodyColorAbnormalityResistanceRules.map(
      (rule) => ({
        colorId: rule.colorId,
        abnormalityResistanceBonuses: Object.entries(rule.abnormalityResistanceBonuses).map(
          ([id, bonus]) => ({ id, bonus }),
        ),
      }),
    ),
  };
}

function toRustHeadShape(headShape: HeadShapeResistanceBonuses) {
  return {
    abnormalityResistanceBonuses: Object.entries(headShape.abnormalityResistanceBonuses).map(
      ([id, bonus]) => ({ id, bonus }),
    ),
    attributeResistanceBonuses: headShape.attributeResistanceBonuses,
  };
}

function toRustSelection(selection: BodyColorSelection) {
  return {
    bodyColors: selection.bodyColors,
    isSpColor: selection.isSpColor,
  };
}

/** Calculates elemental resistance through the shared Rust engine. */
export function calculateAttributeResistance(
  selection: BodyColorSelection,
  masterData: ResistanceMasterData,
): AttributeResistance[] {
  return calculateAttributeResistanceWithRust(
    toRustSelection(selection),
    toRustMasterData(masterData),
  ) as AttributeResistance[];
}

/** Calculates abnormality resistance through the shared Rust engine. */
export function calculateColorAbnormalityResistance(
  selection: BodyColorSelection,
  masterData: ResistanceMasterData,
): AbnormalityResistance[] {
  return calculateColorAbnormalityResistanceWithRust(
    toRustSelection(selection),
    toRustMasterData(masterData),
  ) as AbnormalityResistance[];
}

/** Calculates combined body-color and head-shape resistance through Rust. */
export function calculateDenpaMenResistances(
  selection: BodyColorSelection,
  headShape: HeadShapeResistanceBonuses,
  masterData: ResistanceMasterData,
): DenpaMenResistances {
  return calculateDenpaMenResistancesWithRust(
    toRustSelection(selection),
    toRustHeadShape(headShape),
    toRustMasterData(masterData),
  ) as DenpaMenResistances;
}

/** Finds a matching body-color combination through the shared Rust engine. */
export function findColorCombination(
  target: AttributeResistance[],
  masterData: ResistanceMasterData,
): BodyColorSelection | null {
  return findColorCombinationWithRust(target, toRustMasterData(masterData)) as BodyColorSelection | null;
}

/** Sums growth-stat bonuses through the shared Rust engine. */
export function correctionsStatBonus(
  corrections: CorrectionWithAbnormalityBonuses[],
): DenpaMenStatBonus {
  const result = calculateCorrectionStatBonusWithRust({
    corrections: corrections.map((correction) => ({
      statBonus: {
        hp: correction.hpBonus,
        ap: correction.apBonus,
        attack: correction.attackBonus,
        defense: correction.defenseBonus,
        speed: correction.speedBonus,
        evasionRate: correction.evasionRateBonus,
      },
      abnormalityResistanceBonuses: Object.entries(
        correction.abnormalityResistanceBonuses,
      ).map(([id, bonus]) => ({ id, bonus })),
      attributeResistanceBonuses: [],
    })),
    additionalCorrection: {
      statBonus: {
        hp: 0,
        ap: 0,
        attack: 0,
        defense: 0,
        speed: 0,
        evasionRate: 0,
      },
      abnormalityResistanceBonuses: [],
      attributeResistanceBonuses: [],
    },
  }) as {
    hp: number;
    ap: number;
    attack: number;
    defense: number;
    speed: number;
    evasionRate: number;
  };
  return result;
}
