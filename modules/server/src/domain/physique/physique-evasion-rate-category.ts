export interface PhysiqueEvasionRateCategoryRow {
  evasionRateStart: number;
  evasionRateEnd: number;
  startColumn: number;
  columnOffset: number;
  textKey: string;
}

export interface PhysiqueEvasionRateCategoryRepository {
  find(): Promise<PhysiqueEvasionRateCategoryRow[]>;
}

/**
 * Resolves a `(evasionRate, columnIndex)` pair to the physique category
 * translation key (`largest`/`large`/`medium`/`fast`/`fastest`) it falls
 * under, per `physique_evasion_rate_category` (seeded from
 * `data/physique_evasion_rate_categories.xlsx`). A row matches when
 * `evasionRate` falls within its range and `columnIndex` equals
 * `(startColumn - 1) + columnOffset`. Several rows can match the same
 * `evasionRate` (observed at different `startColumn`s) — the first match
 * is used.
 */
export async function resolvePhysiqueCategoryKey(
  repo: PhysiqueEvasionRateCategoryRepository,
  evasionRate: number,
  columnIndex: number,
): Promise<string | undefined> {
  const categories = await repo.find();
  const match = categories.find(
    (category) =>
      evasionRate >= category.evasionRateStart &&
      evasionRate <= category.evasionRateEnd &&
      columnIndex === category.startColumn - 1 + category.columnOffset,
  );
  return match?.textKey;
}
