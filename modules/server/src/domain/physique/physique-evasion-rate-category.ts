export interface PhysiqueEvasionRateCategoryRow {
  evasionRateStart: number;
  evasionRateEnd: number;
  startColumn: number;
  columnOffset: number;
  textKey: string;
  note: string | null;
}

export interface PhysiqueEvasionRateCategoryRepository {
  find(): Promise<PhysiqueEvasionRateCategoryRow[]>;
}

/** Which side of the evasion-rate table's overlapping column patterns a category falls on, or `null` when the pattern isn't split into a plus/minus pair. */
export type EvasionRateSign = 'plus' | 'minus' | null;

export interface PhysiqueCategoryCandidate {
  textKey: string;
  sign: EvasionRateSign;
  evasionRateStart: number;
  evasionRateEnd: number;
}

const SIGNED_CATEGORY_WORD: Record<string, string> = {
  largest: '最大',
  large: '準大',
  medium: '中間',
  fast: '準速',
  fastest: '最速',
};

/**
 * Reads the plus/minus side off a category row's free-text `note`
 * column, which is the only place that distinction survives from the
 * source spreadsheet — the note names the row's own category word
 * immediately followed by a `+` or `-` sign when the row belongs to a
 * split pattern. Only a sign directly attached to that word counts, so
 * an unrelated dash elsewhere in the note is never mistaken for one.
 * Returns `null` when the row's pattern isn't split into a plus/minus
 * pair.
 */
export function inferEvasionRateSign(note: string | null, textKey: string): EvasionRateSign {
  if (!note) return null;
  const word = SIGNED_CATEGORY_WORD[textKey];
  if (!word) return null;
  const match = note.match(new RegExp(`${word}([+-])`));
  if (!match) return null;
  return match[1] === '+' ? 'plus' : 'minus';
}

/**
 * Resolves a `(evasionRate, columnIndex)` pair to every physique category
 * candidate it falls under, per `physique_evasion_rate_category` (seeded
 * from `data/physique_evasion_rate_categories.xlsx`). A row matches when
 * `evasionRate` falls within its range and `columnIndex` equals
 * `(startColumn - 1) + columnOffset`. More than one row can match the
 * same `(evasionRate, columnIndex)` pair — e.g. the plus and minus sides
 * of the same category observed at different `startColumn`s — in which
 * case every matching candidate is returned, each carrying its own
 * `sign` and evasion-rate range, so the caller can let the user pick
 * between them rather than silently guessing one.
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
      columnIndex === category.startColumn - 1 + category.columnOffset,
  );
  const candidates = matches.map((match) => ({
    textKey: match.textKey,
    sign: inferEvasionRateSign(match.note, match.textKey),
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
