import path from 'node:path';
import type { DataSource } from 'typeorm';
import { describe, expect, test } from 'vitest';
import { PhysiqueEvasionRateCategoryEntity } from '../../src/entities/physique-evasion-rate-category.entity';
import { loadPhysiqueEvasionRateCategories } from '../../src/seed/loaders/load-physique-evasion-rate-categories';

const DATA_DIR = path.resolve(import.meta.dirname, '..', '..', 'data');

function fakeDataSource(saved: PhysiqueEvasionRateCategoryEntity[][]): DataSource {
  return {
    getRepository: () => ({
      save: async (entities: PhysiqueEvasionRateCategoryEntity[]) => {
        saved.push(entities);
        return entities;
      },
    }),
  } as unknown as DataSource;
}

describe('loadPhysiqueEvasionRateCategories', () => {
  test('parses the real spreadsheet without throwing, into columnIndex/sign rows', async () => {
    const saved: PhysiqueEvasionRateCategoryEntity[][] = [];
    await loadPhysiqueEvasionRateCategories(fakeDataSource(saved), DATA_DIR);

    const entities = saved.flat();
    expect(entities.length).toBeGreaterThan(0);
    expect(entities.every((entity) => Number.isInteger(entity.columnIndex) && entity.columnIndex >= 0)).toBe(true);
    expect(entities.every((entity) => entity.evasionRateStart === entity.evasionRateEnd)).toBe(true);
    expect(entities.every((entity) => entity.evasionRateStart >= 0)).toBe(true);
    expect(entities.every((entity) => ['plus', 'minus', null].includes(entity.sign))).toBe(true);

    const evasionRate3 = entities.filter((entity) => entity.evasionRateStart === 3);
    expect(evasionRate3.some((entity) => entity.sign === 'plus')).toBe(true);
    expect(evasionRate3.some((entity) => entity.sign === 'minus')).toBe(true);
  });
});
