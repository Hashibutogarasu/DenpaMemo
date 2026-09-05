/** Which side of the evasion-rate table's overlapping column patterns a category falls on, or `null` when the pattern isn't split into a plus/minus pair. */
export type EvasionRateSign = 'plus' | 'minus' | null;

export interface PhysiqueEvasionRateCategoryRow {
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

/**
 * Resolves a `(evasionRate, columnIndex)` pair to every physique category
 * candidate it falls under, per `physique_evasion_rate_category` (seeded
 * from `data/physique_evasion_rate_categories.xlsx`). A row matches when
 * `evasionRate` falls within its range and `columnIndex` matches exactly.
 * More than one row can match the same `(evasionRate, columnIndex)`
 * pair — e.g. the plus and minus sides of the same category, or a
 * legend cell naming more than one category — in which case every
 * matching candidate is returned, each carrying its own `sign` and
 * evasion-rate range, so the caller can let the user pick between them
 * rather than silently guessing one.
 */
export async function resolvePhysiqueCategoryKeys(
  repo: PhysiqueEvasionRateCategoryRepository,
  evasionRate: number,
  columnIndex: number,
): Promise<PhysiqueCategoryCandidate[]> {
  const categories = await repo.find();
  const matches = categories.filter(
    (category) =>
      evasionRate >= category.evasionRateStart &&
      evasionRate <= category.evasionRateEnd &&
      columnIndex === category.columnIndex,
  );
  const candidates = matches.map((match) => ({
    textKey: match.textKey,
    sign: match.sign,
    evasionRateStart: match.evasionRateStart,
    evasionRateEnd: match.evasionRateEnd,
  }));
  const seen = new Set<string>();
  return candidates.filter((candidate) => {
    const key = `${candidate.textKey} ${candidate.sign} ${candidate.evasionRateStart} ${candidate.evasionRateEnd}`;
    if (seen.has(key)) return false;
    seen.add(key);
    return true;
  });
}
