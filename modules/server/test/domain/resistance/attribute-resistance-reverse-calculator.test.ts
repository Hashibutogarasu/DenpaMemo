import { describe, expect, test } from 'vitest';
import { calculateAttributeResistance } from '../../../src/domain/resistance/attribute-resistance-calculator';
import { findColorCombination } from '../../../src/domain/resistance/attribute-resistance-reverse-calculator';
import { masterData } from '../../fixtures/master-data.fixture';
import type { BodyColorSelection } from '../../../src/domain/resistance/types';

function expectRoundTrip(selection: BodyColorSelection) {
  const target = calculateAttributeResistance(selection, masterData);
  const found = findColorCombination(target, masterData);

  expect(found).not.toBeNull();
  const reconstructed = calculateAttributeResistance(found!, masterData);

  const targetByAttribute = Object.fromEntries(target.map((r) => [r.attributeId, r.value]));
  const reconstructedByAttribute = Object.fromEntries(reconstructed.map((r) => [r.attributeId, r.value]));
  expect(reconstructedByAttribute).toEqual(targetByAttribute);
}

describe('attribute resistance reverse lookup', () => {
  test('reverses blue as an SP color', () => {
    expectRoundTrip({ bodyColors: ['blue'], isSpColor: true });
  });

  test('reverses gold as an SP color', () => {
    expectRoundTrip({ bodyColors: ['gold'], isSpColor: true });
  });

  test('reverses silver as an SP color', () => {
    expectRoundTrip({ bodyColors: ['silver'], isSpColor: true });
  });

  test('reverses pink as an SP color', () => {
    expectRoundTrip({ bodyColors: ['pink'], isSpColor: true });
  });

  test('reverses gold + silver', () => {
    expectRoundTrip({ bodyColors: ['gold', 'silver'], isSpColor: false });
  });

  test('reverses pink + pink', () => {
    expectRoundTrip({ bodyColors: ['pink', 'pink'], isSpColor: false });
  });

  test('reverses pink + red', () => {
    expectRoundTrip({ bodyColors: ['pink', 'red'], isSpColor: false });
  });

  test('reverses white + white', () => {
    expectRoundTrip({ bodyColors: ['white', 'white'], isSpColor: false });
  });

  test('reverses yellow + black', () => {
    expectRoundTrip({ bodyColors: ['yellow', 'black'], isSpColor: false });
  });
});
