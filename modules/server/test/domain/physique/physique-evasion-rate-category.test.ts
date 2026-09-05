import { describe, expect, test } from 'vitest';
import { inferEvasionRateSign, resolvePhysiqueCategoryKeys } from '../../../src/domain/physique/physique-evasion-rate-category';

const categories = [
  { evasionRateStart: 0, evasionRateEnd: 0, startColumn: 1, columnOffset: 0, textKey: 'largest', note: '' },
  { evasionRateStart: 0, evasionRateEnd: 0, startColumn: 1, columnOffset: 1, textKey: 'large', note: '' },
  { evasionRateStart: 3, evasionRateEnd: 3, startColumn: 2, columnOffset: 1, textKey: 'largest', note: '' },
  { evasionRateStart: 3, evasionRateEnd: 3, startColumn: 3, columnOffset: 0, textKey: 'large', note: '' },
  { evasionRateStart: 6, evasionRateEnd: 10, startColumn: 5, columnOffset: 1, textKey: 'large', note: '準大-(3列分)のうち1列目' },
  { evasionRateStart: 6, evasionRateEnd: 6, startColumn: 4, columnOffset: 1, textKey: 'large', note: '' },
];

const fakeRepo = { find: async () => categories };

describe('inferEvasionRateSign', () => {
  test('reads the sign attached to the row\'s own category word', () => {
    expect(inferEvasionRateSign('準速+(3列分)のうち1列目', 'fast')).toBe('plus');
    expect(inferEvasionRateSign('準大-(3列分)のうち1列目', 'large')).toBe('minus');
  });

  test('ignores unrelated dashes elsewhere in the note', () => {
    expect(inferEvasionRateSign('元表記「最大(中間)(3列分)」の1列目 - mediumの可能性あり、要確認', 'largest')).toBeNull();
  });

  test('returns null for an empty or missing note', () => {
    expect(inferEvasionRateSign('', 'fast')).toBeNull();
    expect(inferEvasionRateSign(null, 'fast')).toBeNull();
  });
});

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
    expect(await resolvePhysiqueCategoryKeys(fakeRepo, 8, 5)).toEqual([
      { textKey: 'large', sign: 'minus', evasionRateStart: 6, evasionRateEnd: 10 },
    ]);
  });

  test('returns every candidate when overlapping patterns share the same evasionRate and columnIndex, each carrying its own sign', async () => {
    expect(await resolvePhysiqueCategoryKeys(fakeRepo, 3, 2)).toEqual([
      { textKey: 'largest', sign: null, evasionRateStart: 3, evasionRateEnd: 3 },
      { textKey: 'large', sign: null, evasionRateStart: 3, evasionRateEnd: 3 },
    ]);
  });

  test('returns an empty array when nothing matches', async () => {
    expect(await resolvePhysiqueCategoryKeys(fakeRepo, 999, 0)).toEqual([]);
  });
});
