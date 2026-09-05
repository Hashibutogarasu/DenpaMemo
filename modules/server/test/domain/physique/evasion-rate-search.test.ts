import { describe, expect, test } from 'vitest';
import { findEvasionRateMatches, type PhysiqueTableRowLike } from '../../../src/domain/physique/evasion-rate-search';

/**
 * Reproduces the level-1 / no-antenna evasion-rate rows and HP row that
 * previously failed to identify a physique category for evasionRate=0,
 * hp=32.
 */
const evasionRateRows: PhysiqueTableRowLike[] = [
  { level: '1', anntenaCategory: 'アンテナ無し', lineOffset: 0, values: [0, 0, 0, 0, 0, null, null, null, null, null] },
  { level: '1', anntenaCategory: 'アンテナ無し', lineOffset: 1, values: [null, 3, 3, 3, 3, 3, 3, null, null, null] },
  { level: '1', anntenaCategory: 'アンテナ無し', lineOffset: 2, values: [null, null, null, 6, 6, 6, 6, 6, null, null] },
  { level: '1', anntenaCategory: 'アンテナ無し', lineOffset: 3, values: [null, null, null, null, null, 10, 10, null, 10, null] },
  { level: '1', anntenaCategory: 'アンテナ無し', lineOffset: 4, values: [null, null, null, null, null, null, null, 15, 15, 15] },
];

const hpRows: PhysiqueTableRowLike[] = [
  { level: '1', anntenaCategory: 'アンテナ無し', lineOffset: 0, values: [40, 37, 34, 32, 29, 26, 24, 21, 18, 16] },
];

describe('findEvasionRateMatches', () => {
  test('matches a column even when a later row overlaps it with a different evasion-rate value', () => {
    const matches = findEvasionRateMatches(evasionRateRows, hpRows, 0, 32);
    expect(matches).toEqual([{ level: '1', anntenaCategory: 'アンテナ無し', lineOffset: 0, columnIndex: 3 }]);
  });

  test('still matches columns not touched by any overlapping row', () => {
    expect(findEvasionRateMatches(evasionRateRows, hpRows, 3, 26)).toEqual([
      { level: '1', anntenaCategory: 'アンテナ無し', lineOffset: 1, columnIndex: 5 },
    ]);
  });
});
