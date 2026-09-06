import { buildCategoryGrid, compactCategories } from 'denpamen_logics';
import type { PhysiqueTableRowLike } from './evasion-rate-search';
import type { EvasionRateSign, PhysiqueEvasionRateCategoryRow } from './physique-evasion-rate-category';

export interface LegendCell {
  categoryId: string;
  evasionRateStart: number;
  evasionRateEnd: number;
  columnIndex: number;
  textKey: string;
  sign: EvasionRateSign;
  liveValues: number[];
  isMatch: boolean;
}

export interface HpCell {
  columnIndex: number;
  lineOffset: number;
  value: number;
  isMatch: boolean;
}

export interface LegendGridResult {
  legendCells: LegendCell[];
  hpCells: HpCell[];
}

function toRustCategory(row: PhysiqueEvasionRateCategoryRow) {
  return {
    id: row.id ?? '',
    rangeStart: row.evasionRateStart,
    rangeEnd: row.evasionRateEnd,
    columnIndex: row.columnIndex,
    categoryKey: row.textKey,
    tag: row.sign,
  };
}

function toRustRow(row: PhysiqueTableRowLike) {
  return { group: [row.level, row.anntenaCategory], lineOffset: row.lineOffset, values: row.values };
}

/**
 * Merges adjacent legend rows in the same column that share the same
 * category and sign into one wider evasion-rate range, without
 * touching the underlying seed data. Delegates to `denpamen_logics`'s
 * generic `compactCategories` (Wasm).
 */
export function compactLegendCategories(
  categories: PhysiqueEvasionRateCategoryRow[],
): PhysiqueEvasionRateCategoryRow[] {
  const compacted = compactCategories(categories.map(toRustCategory)) as {
    id: string;
    rangeStart: number;
    rangeEnd: number;
    columnIndex: number;
    categoryKey: string;
    tag: EvasionRateSign;
  }[];
  return compacted.map((category) => ({
    id: category.id,
    evasionRateStart: category.rangeStart,
    evasionRateEnd: category.rangeEnd,
    columnIndex: category.columnIndex,
    textKey: category.categoryKey,
    sign: category.tag,
  }));
}

/**
 * Builds the "matching location" grid: every legend category paired
 * with whichever real evasion-rate values (for the given level/antenna
 * group) fall in its range, plus the HP table's values for the same
 * group — each flagged with whether it is literally the cell an
 * identification search matched. Delegates the actual grid construction
 * to `denpamen_logics`'s generic, domain-agnostic `buildCategoryGrid`
 * (Wasm), converting to/from its shape at the boundary.
 */
export function buildLegendGrid(params: {
  categories: PhysiqueEvasionRateCategoryRow[];
  evasionRateRows: PhysiqueTableRowLike[];
  hpRows: PhysiqueTableRowLike[];
  matchColumnIndex: number;
  matchLineOffset: number;
  matchEvasionRate: number;
}): LegendGridResult {
  const { categories, evasionRateRows, hpRows, matchColumnIndex, matchLineOffset, matchEvasionRate } = params;
  const grid = buildCategoryGrid({
    categories: categories.map(toRustCategory),
    primaryRows: evasionRateRows.map(toRustRow),
    companionRows: hpRows.map(toRustRow),
    matchColumnIndex,
    matchLineOffset,
    matchValue: matchEvasionRate,
  }) as {
    categoryCells: {
      categoryId: string;
      rangeStart: number;
      rangeEnd: number;
      columnIndex: number;
      categoryKey: string;
      tag: EvasionRateSign;
      liveValues: number[];
      isMatch: boolean;
    }[];
    valueCells: { columnIndex: number; lineOffset: number; value: number; isMatch: boolean }[];
  };

  return {
    legendCells: grid.categoryCells.map((cell) => ({
      categoryId: cell.categoryId,
      evasionRateStart: cell.rangeStart,
      evasionRateEnd: cell.rangeEnd,
      columnIndex: cell.columnIndex,
      textKey: cell.categoryKey,
      sign: cell.tag,
      liveValues: cell.liveValues,
      isMatch: cell.isMatch,
    })),
    hpCells: grid.valueCells,
  };
}
