import path from 'node:path';
import { readFile } from 'node:fs/promises';
import { read, utils } from 'xlsx';
import type { DataSource } from 'typeorm';
import { PhysiqueEvasionRateCategoryEntity } from '../../entities/physique-evasion-rate-category.entity';

const CATEGORY_WORD_TO_TEXT_KEY: Record<string, string> = {
  最大: 'largest',
  準大: 'large',
  中間: 'medium',
  準速: 'fast',
  最速: 'fastest',
};

const CELL_SEGMENT_PATTERN = /^(最大|準大|中間|準速|最速)([+-])?(\(.+\))?$/;

const SPREADSHEET_COLUMN_COUNT = 10;

interface ParsedCellSegment {
  textKey: string;
  sign: 'plus' | 'minus' | null;
  note: string | null;
}

/**
 * Parses one legend cell's text into every physique category it names.
 * A cell can name more than one category separated by a slash when the
 * source spreadsheet's column slot legitimately maps to more than one
 * category. Each category word can carry a trailing plus/minus sign and
 * a parenthesised annotation, both kept verbatim rather than guessed at.
 */
function parseLegendCell(text: string): ParsedCellSegment[] {
  return text
    .split('/')
    .map((segment) => segment.trim())
    .filter((segment) => segment.length > 0)
    .map((segment) => {
      const match = segment.match(CELL_SEGMENT_PATTERN);
      if (!match) {
        throw new Error(`Unrecognized physique category legend cell: "${segment}"`);
      }
      const [, word, sign, note] = match;
      return {
        textKey: CATEGORY_WORD_TO_TEXT_KEY[word],
        sign: sign === '+' ? 'plus' : sign === '-' ? 'minus' : null,
        note: note ?? null,
      };
    });
}

interface LegendSheetRow {
  __EMPTY: number;
  [spreadsheetColumn: string]: unknown;
}

/**
 * Loads `data/physique_evasion_rate_categories.xlsx` — a hand-edited
 * transcription of the evasion-rate table's physique-category legend.
 * One sheet row is one evasion-rate value; the un-headed column (read
 * by `xlsx` as `__EMPTY`) holds that value, signed only where the
 * legend needs two distinct patterns for the same absolute evasion
 * rate (e.g. `3` and `-3`) — the sign there is a spreadsheet-authoring
 * device, not a physique-category sign, so only its magnitude is a
 * real evasion rate. Spreadsheet columns `1`-`10` are the evasion-rate
 * table's column slots (`columnIndex = spreadsheetColumn - 1`); a
 * populated cell names the physique categor(ies) that slot resolves to
 * for that row's evasion rate, per `parseLegendCell`.
 */
export async function loadPhysiqueEvasionRateCategories(dataSource: DataSource, dataDir: string): Promise<void> {
  const filePath = path.join(dataDir, 'physique_evasion_rate_categories.xlsx');
  const workbook = read(await readFile(filePath));
  const sheet = workbook.Sheets[workbook.SheetNames[0]];
  const rows = utils.sheet_to_json<LegendSheetRow>(sheet, { defval: null });

  const entities: PhysiqueEvasionRateCategoryEntity[] = [];
  for (const row of rows) {
    const evasionRate = Math.abs(row.__EMPTY);
    for (let spreadsheetColumn = 1; spreadsheetColumn <= SPREADSHEET_COLUMN_COUNT; spreadsheetColumn += 1) {
      const cellText = row[String(spreadsheetColumn)];
      if (typeof cellText !== 'string' || cellText.length === 0) continue;

      for (const segment of parseLegendCell(cellText)) {
        const entity = new PhysiqueEvasionRateCategoryEntity();
        entity.evasionRateStart = evasionRate;
        entity.evasionRateEnd = evasionRate;
        entity.columnIndex = spreadsheetColumn - 1;
        entity.textKey = segment.textKey;
        entity.sign = segment.sign;
        entity.note = segment.note;
        entities.push(entity);
      }
    }
  }

  await dataSource.getRepository(PhysiqueEvasionRateCategoryEntity).save(entities);
}
