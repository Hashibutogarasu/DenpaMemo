import { describe, expect, test } from 'vitest';
import { calculateDenpaMenResistances } from '../../../src/domain/resistance/denpa-men-resistance-calculator';
import { elementalAttributeIds, masterData } from '../../fixtures/master-data.fixture';

const noBonuses = { abnormalityResistanceBonuses: {}, attributeResistanceBonuses: [] };

describe('head shape resistance layered on top of body color', () => {
  test('bowlCut grants +1 to every attribute on top of solo black (no attribute bonus of its own)', () => {
    const headShape = {
      abnormalityResistanceBonuses: { jack: 1 },
      attributeResistanceBonuses: elementalAttributeIds.map((attributeId) => ({ attributeId, bonus: 1 })),
    };
    const result = calculateDenpaMenResistances({ bodyColors: ['black'], isSpColor: false }, headShape, masterData);
    const byAttribute = Object.fromEntries(result.attributeResistance.map((r) => [r.attributeId, r.value]));
    for (const attributeId of elementalAttributeIds) {
      expect(byAttribute[attributeId]).toBe(1);
    }
  });

  test('light head shape grants +2 to every attribute and layers abnormality bonuses', () => {
    const headShape = {
      abnormalityResistanceBonuses: { poison: 2, burn: 2 },
      attributeResistanceBonuses: elementalAttributeIds.map((attributeId) => ({ attributeId, bonus: 2 })),
    };
    const result = calculateDenpaMenResistances({ bodyColors: ['black'], isSpColor: false }, headShape, masterData);
    const byAttribute = Object.fromEntries(result.attributeResistance.map((r) => [r.attributeId, r.value]));
    for (const attributeId of elementalAttributeIds) {
      expect(byAttribute[attributeId]).toBe(2);
    }
    const byAbnormality = Object.fromEntries(result.abnormalityResistances.map((r) => [r.abnormalityId, r.value]));
    expect(byAbnormality).toEqual({ poison: 2, burn: 2, sleep: 1 });
  });

  test('sun (no attribute bonus of its own) leaves no attribute resistance for solo black', () => {
    const result = calculateDenpaMenResistances({ bodyColors: ['black'], isSpColor: false }, noBonuses, masterData);
    expect(result.attributeResistance).toEqual([]);
  });

  test('attribute resistance is sorted by attribute.index', () => {
    const headShape = {
      abnormalityResistanceBonuses: {},
      attributeResistanceBonuses: [
        { attributeId: 'dark', bonus: 1 },
        { attributeId: 'fire', bonus: 1 },
        { attributeId: 'ice', bonus: 1 },
      ],
    };
    const result = calculateDenpaMenResistances({ bodyColors: ['black'], isSpColor: false }, headShape, masterData);
    expect(result.attributeResistance.map((r) => r.attributeId)).toEqual(['fire', 'ice', 'dark']);
  });
});
