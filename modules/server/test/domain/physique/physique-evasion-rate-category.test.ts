import { describe, expect, test } from 'vitest';
import { resolvePhysiqueCategoryKey } from '../../../src/domain/physique/physique-evasion-rate-category';

const categories = [
  { evasionRateStart: 0, evasionRateEnd: 0, startColumn: 1, columnOffset: 0, textKey: 'largest' },
  { evasionRateStart: 0, evasionRateEnd: 0, startColumn: 1, columnOffset: 1, textKey: 'large' },
  { evasionRateStart: 3, evasionRateEnd: 3, startColumn: 2, columnOffset: 0, textKey: 'largest' },
  { evasionRateStart: 3, evasionRateEnd: 3, startColumn: 2, columnOffset: 0, textKey: 'medium' },
  { evasionRateStart: 6, evasionRateEnd: 10, startColumn: 5, columnOffset: 1, textKey: 'large' },
];

const fakeRepo = { find: async () => categories };

describe('resolvePhysiqueCategoryKey', () => {
  test('finds the row matching evasionRate and columnIndex', async () => {
    expect(await resolvePhysiqueCategoryKey(fakeRepo, 0, 0)).toBe('largest');
    expect(await resolvePhysiqueCategoryKey(fakeRepo, 0, 1)).toBe('large');
  });

  test('resolves evasionRate against a range, not just an exact value', async () => {
    expect(await resolvePhysiqueCategoryKey(fakeRepo, 8, 5)).toBe('large');
  });

  test('returns the first match when multiple rows share the same evasionRate and columnIndex', async () => {
    expect(await resolvePhysiqueCategoryKey(fakeRepo, 3, 1)).toBe('largest');
  });

  test('returns undefined when nothing matches', async () => {
    expect(await resolvePhysiqueCategoryKey(fakeRepo, 999, 0)).toBeUndefined();
  });
});
