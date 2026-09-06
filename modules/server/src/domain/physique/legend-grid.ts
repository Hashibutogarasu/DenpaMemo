import { collectColumns, type PhysiqueTableRowLike } from './evasion-rate-search';
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

/**
 * Merges adjacent legend rows in the same column that share the same
 * category and sign into one wider evasion-rate range, without
 * touching the underlying seed data. The source spreadsheet expands a
 * range like "7~10" into one row per value (see
 * `load-physique-evasion-rate-categories.ts`), which is faithful to the
 * spreadsheet but noisy to display; this collapses runs of consecutive
 * evasion-rate values back into a single range wherever their content
 * is identical. Rows that merely share a start value but differ in sign
 * (e.g. the evasion-rate-3 plus/minus pair) are never merged, since they
 * represent genuinely different categories.
 */
export function compactLegendCategories(
  categories: PhysiqueEvasionRateCategoryRow[],
): PhysiqueEvasionRateCategoryRow[] {
  const byColumn = new Map<number, PhysiqueEvasionRateCategoryRow[]>();
  for (const category of categories) {
    const group = byColumn.get(category.columnIndex);
    if (group) {
      group.push(category);
    } else {
      byColumn.set(category.columnIndex, [category]);
    }
  }

  function canExtend(
    previous: PhysiqueEvasionRateCategoryRow,
    next: PhysiqueEvasionRateCategoryRow,
  ): boolean {
    return (
      previous.textKey === next.textKey &&
      previous.sign === next.sign &&
      previous.evasionRateEnd + 1 === next.evasionRateStart
    );
  }

  const compacted: PhysiqueEvasionRateCategoryRow[] = [];
  for (const group of byColumn.values()) {
    const ordered = [...group].sort((a, b) => a.evasionRateStart - b.evasionRateStart);
    for (const row of ordered) {
      const last = compacted.at(-1);
      if (last !== undefined && last.columnIndex === row.columnIndex && canExtend(last, row)) {
        compacted[compacted.length - 1] = { ...last, evasionRateEnd: row.evasionRateEnd };
      } else {
        compacted.push({ ...row });
      }
    }
  }
  return compacted;
}

/**
 * Builds the "matching location" grid: every legend category paired
 * with whichever real evasion-rate values (for the given level/antenna
 * group) fall in its range, plus the HP table's values for the same
 * group — each flagged with whether it is literally the cell an
 * identification search matched.
 */
export function buildLegendGrid(params: {
  categories: PhysiqueEvasionRateCategoryRow[];
  evasionRateRows: PhysiqueTableRowLike[];
  hpRows: PhysiqueTableRowLike[];
  matchColumnIndex: number;
  matchLineOffset: number;
  matchEvasionRate: number;
}): LegendGridResult {
  const { evasionRateRows, hpRows, matchColumnIndex, matchLineOffset, matchEvasionRate } = params;
  const categories = compactLegendCategories(params.categories);
  const evasionColumns = collectColumns(evasionRateRows);
  const hpColumns = collectColumns(hpRows);

  const legendCells: LegendCell[] = categories.map((category) => {
    const column = evasionColumns[category.columnIndex] ?? [];
    const liveValues = [
      ...new Set(
        column
          .map((entry) => entry.value)
          .filter((value) => value >= category.evasionRateStart && value <= category.evasionRateEnd),
      ),
    ];
    const isMatch =
      category.columnIndex === matchColumnIndex &&
      matchEvasionRate >= category.evasionRateStart &&
      matchEvasionRate <= category.evasionRateEnd;
    return {
      categoryId: category.id,
      evasionRateStart: category.evasionRateStart,
      evasionRateEnd: category.evasionRateEnd,
      columnIndex: category.columnIndex,
      textKey: category.textKey,
      sign: category.sign,
      liveValues,
      isMatch,
    };
  });

  const hpCells: HpCell[] = hpColumns.flatMap((entries, columnIndex) =>
    entries.map((entry) => ({
      columnIndex,
      lineOffset: entry.lineOffset,
      value: entry.value,
      isMatch: columnIndex === matchColumnIndex && entry.lineOffset === matchLineOffset,
    })),
  );

  return { legendCells, hpCells };
}
