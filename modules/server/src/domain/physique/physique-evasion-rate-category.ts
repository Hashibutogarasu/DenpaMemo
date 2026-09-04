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
 * Resolves a `(evasionRate, columnIndex)` pair to every physique category
 * translation key (`largest`/`large`/`medium`/`fast`/`fastest`) it falls
 * under, per `physique_evasion_rate_category` (seeded from
 * `data/physique_evasion_rate_categories.xlsx`). A row matches when
 * `evasionRate` falls within its range and `columnIndex` equals
 * `(startColumn - 1) + columnOffset`. More than one row can match the
 * same `(evasionRate, columnIndex)` pair — e.g. two overlapping patterns
 * observed at different `startColumn`s — in which case every matching
 * key is returned so the caller can let the user pick between them,
 * rather than silently guessing one.
 */
export async function resolvePhysiqueCategoryKeys(
  repo: PhysiqueEvasionRateCategoryRepository,
  evasionRate: number,
  columnIndex: number,
): Promise<string[]> {
  const categories = await repo.find();
  const matches = categories.filter(
    (category) =>
      evasionRate >= category.evasionRateStart &&
      evasionRate <= category.evasionRateEnd &&
      columnIndex === category.startColumn - 1 + category.columnOffset,
  );
  return [...new Set(matches.map((match) => match.textKey))];
}
