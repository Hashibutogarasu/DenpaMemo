import { describe, expect, test } from 'vitest';
import { buildLegendGrid, compactLegendCategories } from '../../../src/domain/physique/legend-grid';
import type { PhysiqueEvasionRateCategoryRow } from '../../../src/domain/physique/physique-evasion-rate-category';

describe('compactLegendCategories', () => {
  test('merges consecutive same-category rows in a column into one range', () => {
    const categories: PhysiqueEvasionRateCategoryRow[] = [
      { id: '7', evasionRateStart: 7, evasionRateEnd: 7, columnIndex: 4, textKey: 'large', sign: 'minus' },
      { id: '8', evasionRateStart: 8, evasionRateEnd: 8, columnIndex: 4, textKey: 'large', sign: 'minus' },
      { id: '9', evasionRateStart: 9, evasionRateEnd: 9, columnIndex: 4, textKey: 'large', sign: 'minus' },
      { id: '10', evasionRateStart: 10, evasionRateEnd: 10, columnIndex: 4, textKey: 'large', sign: 'minus' },
    ];
    expect(compactLegendCategories(categories)).toEqual([
      { id: '7', evasionRateStart: 7, evasionRateEnd: 10, columnIndex: 4, textKey: 'large', sign: 'minus' },
    ]);
  });

  test('does not merge rows that share a start value but differ in sign', () => {
    const categories: PhysiqueEvasionRateCategoryRow[] = [
      { id: 'plus3', evasionRateStart: 3, evasionRateEnd: 3, columnIndex: 1, textKey: 'fast', sign: 'plus' },
      { id: 'minus3', evasionRateStart: 3, evasionRateEnd: 3, columnIndex: 1, textKey: 'fast', sign: 'minus' },
    ];
    expect(compactLegendCategories(categories)).toEqual(categories);
  });

  test('does not merge rows with a gap between them', () => {
    const categories: PhysiqueEvasionRateCategoryRow[] = [
      { id: 'a', evasionRateStart: 0, evasionRateEnd: 0, columnIndex: 0, textKey: 'largest', sign: null },
      { id: 'b', evasionRateStart: 6, evasionRateEnd: 6, columnIndex: 0, textKey: 'largest', sign: null },
    ];
    expect(compactLegendCategories(categories)).toEqual(categories);
  });
});

describe('buildLegendGrid', () => {
  const categories: PhysiqueEvasionRateCategoryRow[] = [
    { id: 'zero', evasionRateStart: 0, evasionRateEnd: 0, columnIndex: 0, textKey: 'largest', sign: null },
    { id: 'six', evasionRateStart: 6, evasionRateEnd: 6, columnIndex: 3, textKey: 'medium', sign: null },
  ];
  const evasionRateRows = [
    { level: '1', anntenaCategory: 'アンテナ無し', lineOffset: 0, values: [0, null, null, null] },
    { level: '1', anntenaCategory: 'アンテナ無し', lineOffset: 1, values: [null, null, null, 6] },
  ];
  const hpRows = [{ level: '1', anntenaCategory: 'アンテナ無し', lineOffset: 0, values: [40, null, null, 32] }];

  test('marks liveValues where a legend range and a real value coincide, and isMatch for the queried cell', () => {
    const result = buildLegendGrid({
      categories,
      evasionRateRows,
      hpRows,
      matchColumnIndex: 3,
      matchLineOffset: 1,
      matchEvasionRate: 6,
    });

    expect(result.legendCells).toEqual([
      {
        categoryId: 'zero',
        evasionRateStart: 0,
        evasionRateEnd: 0,
        columnIndex: 0,
        textKey: 'largest',
        sign: null,
        liveValues: [0],
        isMatch: false,
      },
      {
        categoryId: 'six',
        evasionRateStart: 6,
        evasionRateEnd: 6,
        columnIndex: 3,
        textKey: 'medium',
        sign: null,
        liveValues: [6],
        isMatch: true,
      },
    ]);
  });

  test('flattens HP rows into per-column cells, flagging only the matched (lineOffset, columnIndex)', () => {
    const result = buildLegendGrid({
      categories,
      evasionRateRows,
      hpRows,
      matchColumnIndex: 3,
      matchLineOffset: 0,
      matchEvasionRate: 6,
    });

    expect(result.hpCells).toEqual([
      { columnIndex: 0, lineOffset: 0, value: 40, isMatch: false },
      { columnIndex: 3, lineOffset: 0, value: 32, isMatch: true },
    ]);
  });

  test('a legend cell with no coinciding real value has an empty liveValues', () => {
    const result = buildLegendGrid({
      categories: [{ id: 'three', evasionRateStart: 3, evasionRateEnd: 3, columnIndex: 0, textKey: 'largest', sign: null }],
      evasionRateRows,
      hpRows,
      matchColumnIndex: 0,
      matchLineOffset: 0,
      matchEvasionRate: 0,
    });

    expect(result.legendCells[0].liveValues).toEqual([]);
    expect(result.legendCells[0].isMatch).toBe(false);
  });
});
