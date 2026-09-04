import { describe, expect, test } from 'vitest';
import { resolvePhysiqueCategoryKeys } from '../../../src/domain/physique/physique-evasion-rate-category';

const categories = [
  { evasionRateStart: 0, evasionRateEnd: 0, startColumn: 1, columnOffset: 0, textKey: 'largest' },
  { evasionRateStart: 0, evasionRateEnd: 0, startColumn: 1, columnOffset: 1, textKey: 'large' },
  { evasionRateStart: 3, evasionRateEnd: 3, startColumn: 2, columnOffset: 1, textKey: 'largest' },
  { evasionRateStart: 3, evasionRateEnd: 3, startColumn: 3, columnOffset: 0, textKey: 'large' },
  { evasionRateStart: 6, evasionRateEnd: 10, startColumn: 5, columnOffset: 1, textKey: 'large' },
];

const fakeRepo = { find: async () => categories };

describe('resolvePhysiqueCategoryKeys', () => {
  test('finds the row matching evasionRate and columnIndex', async () => {
    expect(await resolvePhysiqueCategoryKeys(fakeRepo, 0, 0)).toEqual(['largest']);
    expect(await resolvePhysiqueCategoryKeys(fakeRepo, 0, 1)).toEqual(['large']);
  });

  test('resolves evasionRate against a range, not just an exact value', async () => {
    expect(await resolvePhysiqueCategoryKeys(fakeRepo, 8, 5)).toEqual(['large']);
  });

  test('returns every candidate key when overlapping patterns share the same evasionRate and columnIndex', async () => {
    expect(await resolvePhysiqueCategoryKeys(fakeRepo, 3, 2)).toEqual(['largest', 'large']);
  });

  test('returns an empty array when nothing matches', async () => {
    expect(await resolvePhysiqueCategoryKeys(fakeRepo, 999, 0)).toEqual([]);
  });
});
