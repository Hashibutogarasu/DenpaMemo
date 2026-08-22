/**
 * Plain, TypeORM/GraphQL-independent shapes mirroring the Dart classes in
 * `lib/domain/master_data/` and `lib/domain/denpa_men/`, so the ported
 * calculators (this directory and `../stats/`) stay pure functions with
 * zero framework dependency — matching the Dart originals.
 */

export interface AttributeBonus {
  attributeId: string;
  bonus: number;
}

export type AttributeCategory = 'elemental' | 'special';

export interface Attribute {
  id: string;
  index: number;
  category: AttributeCategory;
}

export interface BodyColorResistanceRule {
  colorId: string;
  attributeResistanceBonuses: AttributeBonus[];
}

export interface BodyColorAbnormalityResistanceRule {
  colorId: string;
  abnormalityResistanceBonuses: Record<string, number>;
}

/** The subset of `MasterData` (see `master_data.dart`) the resistance calculators need. */
export interface ResistanceMasterData {
  attributes: Attribute[];
  bodyColorResistanceRules: BodyColorResistanceRule[];
  bodyColorAbnormalityResistanceRules: BodyColorAbnormalityResistanceRule[];
}

/** Ports the `BodyColorSelection` typedef from `attribute_resistance_calculator.dart`. */
export interface BodyColorSelection {
  bodyColors: string[];
  isSpColor: boolean;
}

export interface AbnormalityResistance {
  abnormalityId: string;
  value: number;
}

export interface AttributeResistance {
  attributeId: string;
  value: number;
}

export interface HeadShapeResistanceBonuses {
  abnormalityResistanceBonuses: Record<string, number>;
  attributeResistanceBonuses: AttributeBonus[];
}

export interface DenpaMenResistances {
  abnormalityResistances: AbnormalityResistance[];
  attributeResistance: AttributeResistance[];
}
