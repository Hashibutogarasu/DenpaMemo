import type { ResistanceMasterData } from '../../src/domain/resistance/types';

/**
 * Real game data mirrored from `assets/data/attributes/**`,
 * `assets/data/body_color_attribute_resistance.json`, and
 * `assets/data/body_color_abnormality_resistance.json` — the same fixture
 * every ported color-combination test (see `test/domain/resistance/*`)
 * builds on, matching the Dart tests under
 * `test/data/master_data/*_test.dart` they replace.
 */
export const masterData: ResistanceMasterData = {
  attributes: [
    { id: 'fire', index: 0, category: 'elemental' },
    { id: 'ice', index: 1, category: 'elemental' },
    { id: 'wind', index: 2, category: 'elemental' },
    { id: 'earth', index: 3, category: 'elemental' },
    { id: 'thunder', index: 4, category: 'elemental' },
    { id: 'water', index: 5, category: 'elemental' },
    { id: 'light', index: 6, category: 'elemental' },
    { id: 'dark', index: 7, category: 'elemental' },
    { id: 'physical', index: 8, category: 'special' },
  ],
  bodyColorResistanceRules: [
    { colorId: 'red', attributeResistanceBonuses: [{ attributeId: 'fire', bonus: 2 }, { attributeId: 'water', bonus: -2 }] },
    { colorId: 'blue', attributeResistanceBonuses: [{ attributeId: 'thunder', bonus: -2 }, { attributeId: 'water', bonus: 2 }] },
    { colorId: 'yellow', attributeResistanceBonuses: [{ attributeId: 'thunder', bonus: 2 }, { attributeId: 'earth', bonus: -2 }] },
    { colorId: 'green', attributeResistanceBonuses: [{ attributeId: 'ice', bonus: -2 }, { attributeId: 'wind', bonus: 2 }] },
    { colorId: 'lightBlue', attributeResistanceBonuses: [{ attributeId: 'fire', bonus: -2 }, { attributeId: 'ice', bonus: 2 }] },
    { colorId: 'orange', attributeResistanceBonuses: [{ attributeId: 'wind', bonus: -2 }, { attributeId: 'earth', bonus: 2 }] },
    { colorId: 'black', attributeResistanceBonuses: [] },
    { colorId: 'purple', attributeResistanceBonuses: [{ attributeId: 'light', bonus: -2 }, { attributeId: 'dark', bonus: 2 }] },
    { colorId: 'white', attributeResistanceBonuses: [{ attributeId: 'light', bonus: 2 }, { attributeId: 'dark', bonus: -2 }] },
    {
      colorId: 'pink',
      attributeResistanceBonuses: [
        { attributeId: 'fire', bonus: -3 },
        { attributeId: 'water', bonus: -3 },
        { attributeId: 'thunder', bonus: -3 },
        { attributeId: 'earth', bonus: -3 },
        { attributeId: 'ice', bonus: -3 },
        { attributeId: 'wind', bonus: -3 },
        { attributeId: 'light', bonus: -3 },
        { attributeId: 'dark', bonus: -3 },
      ],
    },
    { colorId: 'gold', attributeResistanceBonuses: [{ attributeId: 'fire', bonus: -2 }, { attributeId: 'dark', bonus: -2 }] },
    { colorId: 'silver', attributeResistanceBonuses: [{ attributeId: 'thunder', bonus: -2 }, { attributeId: 'water', bonus: -2 }] },
  ],
  bodyColorAbnormalityResistanceRules: [
    { colorId: 'black', abnormalityResistanceBonuses: { sleep: 1 } },
    { colorId: 'red', abnormalityResistanceBonuses: { burn: 1 } },
    { colorId: 'blue', abnormalityResistanceBonuses: { soaked: 1 } },
    { colorId: 'yellow', abnormalityResistanceBonuses: { electrocution: 1 } },
    { colorId: 'lightBlue', abnormalityResistanceBonuses: { frostbite: 1 } },
    { colorId: 'green', abnormalityResistanceBonuses: { cold: 1 } },
    { colorId: 'orange', abnormalityResistanceBonuses: { mud: 1 } },
    { colorId: 'pink', abnormalityResistanceBonuses: { charm: 1 } },
    { colorId: 'purple', abnormalityResistanceBonuses: { curse: 1 } },
    { colorId: 'white', abnormalityResistanceBonuses: { blind: 1 } },
    { colorId: 'gold', abnormalityResistanceBonuses: { paralysis: 1 } },
    { colorId: 'silver', abnormalityResistanceBonuses: { poison: 1 } },
  ],
};

export const elementalAttributeIds = masterData.attributes
  .filter((attribute) => attribute.category === 'elemental')
  .map((attribute) => attribute.id);
