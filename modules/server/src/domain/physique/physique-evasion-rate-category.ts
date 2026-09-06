import { resolveCategories } from 'denpamen_logics';

/** Which side of the evasion-rate table's overlapping column patterns a category falls on, or `null` when the pattern isn't split into a plus/minus pair. */
export type EvasionRateSign = 'plus' | 'minus' | null;

export interface PhysiqueEvasionRateCategoryRow {
  id: string;
  evasionRateStart: number;
  evasionRateEnd: number;
  columnIndex: number;
  textKey: string;
  sign: EvasionRateSign;
}

export interface PhysiqueEvasionRateCategoryRepository {
  find(): Promise<PhysiqueEvasionRateCategoryRow[]>;
}

export interface PhysiqueCategoryCandidate {
  textKey: string;
  sign: EvasionRateSign;
  evasionRateStart: number;
  evasionRateEnd: number;
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

/**
 * Resolves a `(evasionRate, columnIndex)` pair to every physique category
 * candidate it falls under, per `physique_evasion_rate_category` (seeded
 * from `data/physique_evasion_rate_categories.xlsx`). Fetches the full
 * category table via `repo`, then delegates the range/column matching to
 * `denpamen_logics`'s generic, domain-agnostic `resolveCategories`
 * (Wasm).
 */
export async function resolvePhysiqueCategoryKeys(
  repo: PhysiqueEvasionRateCategoryRepository,
  evasionRate: number,
  columnIndex: number,
): Promise<PhysiqueCategoryCandidate[]> {
  const categories = await repo.find();
  const matches = resolveCategories(categories.map(toRustCategory), evasionRate, columnIndex) as {
    categoryKey: string;
    tag: EvasionRateSign;
    rangeStart: number;
    rangeEnd: number;
  }[];
  return matches.map((match) => ({
    textKey: match.categoryKey,
    sign: match.tag,
    evasionRateStart: match.rangeStart,
    evasionRateEnd: match.rangeEnd,
  }));
}
