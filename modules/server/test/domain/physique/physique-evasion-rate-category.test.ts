import { describe, expect, test } from 'vitest';
import { resolvePhysiqueCategoryKeys } from '../../../src/domain/physique/physique-evasion-rate-category';

const categories = [
  { evasionRateStart: 0, evasionRateEnd: 0, columnIndex: 0, textKey: 'largest', sign: null },
  { evasionRateStart: 0, evasionRateEnd: 0, columnIndex: 1, textKey: 'large', sign: null },
  { evasionRateStart: 3, evasionRateEnd: 3, columnIndex: 1, textKey: 'fast', sign: 'plus' },
  { evasionRateStart: 3, evasionRateEnd: 3, columnIndex: 1, textKey: 'fast', sign: 'minus' },
  { evasionRateStart: 6, evasionRateEnd: 10, columnIndex: 1, textKey: 'large', sign: 'minus' },
] as const;

const fakeRepo = { find: async () => categories.map((category) => ({ ...category })) };

describe('resolvePhysiqueCategoryKeys', () => {
  test('finds the row matching evasionRate and columnIndex', async () => {
    expect(await resolvePhysiqueCategoryKeys(fakeRepo, 0, 0)).toEqual([
      { textKey: 'largest', sign: null, evasionRateStart: 0, evasionRateEnd: 0 },
    ]);
    expect(await resolvePhysiqueCategoryKeys(fakeRepo, 0, 1)).toEqual([
      { textKey: 'large', sign: null, evasionRateStart: 0, evasionRateEnd: 0 },
    ]);
  });

  test('resolves evasionRate against a range, not just an exact value', async () => {
    expect(await resolvePhysiqueCategoryKeys(fakeRepo, 8, 1)).toEqual([
      { textKey: 'large', sign: 'minus', evasionRateStart: 6, evasionRateEnd: 10 },
    ]);
  });

  test('returns every candidate when overlapping patterns share the same evasionRate and columnIndex, each carrying its own sign', async () => {
    expect(await resolvePhysiqueCategoryKeys(fakeRepo, 3, 1)).toEqual([
      { textKey: 'fast', sign: 'plus', evasionRateStart: 3, evasionRateEnd: 3 },
      { textKey: 'fast', sign: 'minus', evasionRateStart: 3, evasionRateEnd: 3 },
    ]);
  });

  test('returns an empty array when nothing matches', async () => {
    expect(await resolvePhysiqueCategoryKeys(fakeRepo, 999, 0)).toEqual([]);
  });
});
