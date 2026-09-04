import path from 'node:path';
import { readFile } from 'node:fs/promises';
import { read, utils } from 'xlsx';
import type { DataSource } from 'typeorm';
import { PhysiqueEvasionRateCategoryEntity } from '../../entities/physique-evasion-rate-category.entity';

interface PhysiqueEvasionRateCategoryRow {
  evasionRateStart: number;
  evasionRateEnd: number;
  startColumn: number;
  columnOffset: number;
  textKey: string;
  note?: string;
}

/**
 * Loads `data/physique_evasion_rate_categories.xlsx` — a spreadsheet
 * meant to be hand-edited as the real evasion-rate-table column
 * semantics get refined, rather than a hardcoded lookup table in
 * TypeScript. No `DuplicateIdGuard` check here: unlike the rest of the
 * seed data, rows aren't keyed by a unique id — several rows can share
 * the same `evasionRateStart`/`evasionRateEnd` (see
 * `src/domain/physique/physique-evasion-rate-category.ts`).
 */
export async function loadPhysiqueEvasionRateCategories(dataSource: DataSource, dataDir: string): Promise<void> {
  const filePath = path.join(dataDir, 'physique_evasion_rate_categories.xlsx');
  const workbook = read(await readFile(filePath));
  const sheet = workbook.Sheets[workbook.SheetNames[0]];
  const rows = utils.sheet_to_json<PhysiqueEvasionRateCategoryRow>(sheet);

  const entities = rows.map((row) => {
    const entity = new PhysiqueEvasionRateCategoryEntity();
    entity.evasionRateStart = row.evasionRateStart;
    entity.evasionRateEnd = row.evasionRateEnd;
    entity.startColumn = row.startColumn;
    entity.columnOffset = row.columnOffset;
    entity.textKey = row.textKey;
    entity.note = row.note ?? null;
    return entity;
  });

  await dataSource.getRepository(PhysiqueEvasionRateCategoryEntity).save(entities);
}
