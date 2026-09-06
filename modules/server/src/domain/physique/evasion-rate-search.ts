import { findMatchingColumns } from 'denpamemo_logics';
import type { TableValues } from '../../types/tables/table';

/** A row shape shared by `PhysiqueEvasionRateTableEntity` and `PhysiqueTableEntity`. */
export interface PhysiqueTableRowLike {
  level: string;
  anntenaCategory: string;
  lineOffset: number;
  values: TableValues;
}

export interface EvasionRateMatch {
  level: string;
  anntenaCategory: string;
  lineOffset: number;
  columnIndex: number;
}

function toRustRow(row: PhysiqueTableRowLike) {
  return { group: [row.level, row.anntenaCategory], lineOffset: row.lineOffset, values: row.values };
}

/**
 * Finds every column where an `evasionRateRows` row and an `hpRows` row
 * at the same `level`/`anntenaCategory`/`lineOffset` both equal
 * `targetEvasionRate`/`targetHp` at that column — delegates the actual
 * search to `denpamemo_logics`'s generic, domain-agnostic
 * `findMatchingColumns` (Wasm), converting to/from its `group`-keyed
 * row shape at the boundary.
 */
export function findEvasionRateMatches(
  evasionRateRows: PhysiqueTableRowLike[],
  hpRows: PhysiqueTableRowLike[],
  targetEvasionRate: number,
  targetHp: number,
): EvasionRateMatch[] {
  const primary = { rows: evasionRateRows.map(toRustRow), targetValue: targetEvasionRate };
  const others = [{ rows: hpRows.map(toRustRow), targetValue: targetHp }];
  const matches = findMatchingColumns(primary, others) as {
    group: string[];
    lineOffset: number;
    columnIndex: number;
  }[];
  return matches.map((match) => ({
    level: match.group[0],
    anntenaCategory: match.group[1],
    lineOffset: match.lineOffset,
    columnIndex: match.columnIndex,
  }));
}
