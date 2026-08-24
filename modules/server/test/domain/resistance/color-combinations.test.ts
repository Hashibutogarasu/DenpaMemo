import { describe, expect, test } from 'vitest';
import { calculateAttributeResistance } from '../../../src/domain/resistance/attribute-resistance-calculator';
import { calculateColorAbnormalityResistance } from '../../../src/domain/resistance/color-abnormality-resistance-calculator';
import { elementalAttributeIds, masterData } from '../../fixtures/master-data.fixture';

/**
 * Ports the per-color-combination Dart tests under
 * `test/data/master_data/*_color_test.dart` (blue/pink/black/gold+silver
 * etc.) 1:1 against the same input/expected-output pairs.
 */
describe('attribute resistance color combinations', () => {
  test('blue becomes only water +2 when turned into an SP color', () => {
    const result = calculateAttributeResistance({ bodyColors: ['blue'], isSpColor: true }, masterData);
    expect(result).toEqual([{ attributeId: 'water', value: 2 }]);
  });

  test('pink becomes -1 on every attribute when made SP', () => {
    const result = calculateAttributeResistance({ bodyColors: ['pink'], isSpColor: true }, masterData);
    expect(result).toHaveLength(elementalAttributeIds.length);
    for (const resistance of result) {
      expect(resistance.value).toBe(-1);
    }
  });

  test('pink + pink softens to -2 on every attribute', () => {
    const result = calculateAttributeResistance({ bodyColors: ['pink', 'pink'], isSpColor: false }, masterData);
    expect(result).toHaveLength(elementalAttributeIds.length);
    for (const resistance of result) {
      expect(resistance.value).toBe(-2);
    }
  });

  test('pink + red halves each attribute (distinct pair)', () => {
    const result = calculateAttributeResistance({ bodyColors: ['pink', 'red'], isSpColor: false }, masterData);
    const byAttribute = Object.fromEntries(result.map((r) => [r.attributeId, r.value]));
    expect(byAttribute).toEqual({
      water: Math.trunc((-3 + -2) / 2),
      thunder: Math.trunc(-3 / 2),
      earth: Math.trunc(-3 / 2),
      ice: Math.trunc(-3 / 2),
      wind: Math.trunc(-3 / 2),
      light: Math.trunc(-3 / 2),
      dark: Math.trunc(-3 / 2),
    });
  });

  test('solo black (no bonuses of its own) grants no attribute resistance when not SP', () => {
    const result = calculateAttributeResistance({ bodyColors: ['black'], isSpColor: false }, masterData);
    expect(result).toEqual([]);
  });

  test('solo black grants +1 to every attribute when SP', () => {
    const result = calculateAttributeResistance({ bodyColors: ['black'], isSpColor: true }, masterData);
    expect(result).toHaveLength(elementalAttributeIds.length);
    for (const resistance of result) {
      expect(resistance.value).toBe(1);
    }
  });

  test('gold + silver halves to fire -1, thunder -1, water -1, dark -1', () => {
    const result = calculateAttributeResistance({ bodyColors: ['gold', 'silver'], isSpColor: false }, masterData);
    const byAttribute = Object.fromEntries(result.map((r) => [r.attributeId, r.value]));
    expect(byAttribute).toEqual({ fire: -1, thunder: -1, water: -1, dark: -1 });
  });

  test('gold becomes -1 on fire and -1 on dark when made SP (no positive bonus, not full coverage)', () => {
    const result = calculateAttributeResistance({ bodyColors: ['gold'], isSpColor: true }, masterData);
    const byAttribute = Object.fromEntries(result.map((r) => [r.attributeId, r.value]));
    expect(byAttribute).toEqual({ fire: -2, dark: -2 });
  });

  test('white + white intensifies to light +3, dark -3', () => {
    const result = calculateAttributeResistance({ bodyColors: ['white', 'white'], isSpColor: false }, masterData);
    const byAttribute = Object.fromEntries(result.map((r) => [r.attributeId, r.value]));
    expect(byAttribute).toEqual({ light: 3, dark: -3 });
  });

  test('yellow + black halves yellow bonuses (black contributes nothing)', () => {
    const result = calculateAttributeResistance({ bodyColors: ['yellow', 'black'], isSpColor: false }, masterData);
    const byAttribute = Object.fromEntries(result.map((r) => [r.attributeId, r.value]));
    expect(byAttribute).toEqual({ thunder: 1, earth: -1 });
  });
});

describe('color abnormality resistance', () => {
  test('red + red grants burn +2', () => {
    const result = calculateColorAbnormalityResistance({ bodyColors: ['red', 'red'], isSpColor: false }, masterData);
    expect(result).toEqual([{ abnormalityId: 'burn', value: 2 }]);
  });

  test('red + blue grants both burn +1 and soaked +1, not halved', () => {
    const result = calculateColorAbnormalityResistance({ bodyColors: ['red', 'blue'], isSpColor: false }, masterData);
    const byAbnormality = Object.fromEntries(result.map((r) => [r.abnormalityId, r.value]));
    expect(byAbnormality).toEqual({ burn: 1, soaked: 1 });
  });

  test('solo black grants sleep +1', () => {
    const result = calculateColorAbnormalityResistance({ bodyColors: ['black'], isSpColor: false }, masterData);
    expect(result).toEqual([{ abnormalityId: 'sleep', value: 1 }]);
  });
});
