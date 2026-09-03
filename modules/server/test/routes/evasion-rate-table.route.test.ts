import { describe, expect, test } from 'vitest';
import type { DataSource } from 'typeorm';
import { evasionRateTableRoutes } from '../../src/routes/evasion-rate-table.route';
import { PhysiqueAntennaCategoryEntity } from '../../src/entities/physique-antenna-category.entity';
import { PhysiqueEvasionRateTableEntity } from '../../src/entities/physique-evasion-rate-table.entity';
import { PhysiqueTableEntity } from '../../src/entities/physique-table.entity';

function mockDataSource(options: {
  evasionRateRows: Partial<PhysiqueEvasionRateTableEntity>[];
  hpRows: Partial<PhysiqueTableEntity>[];
}): DataSource {
  const repos = new Map<unknown, { find: () => Promise<unknown[]> }>([
    [PhysiqueEvasionRateTableEntity, { find: async () => options.evasionRateRows }],
    [PhysiqueTableEntity, { find: async () => options.hpRows }],
    [PhysiqueAntennaCategoryEntity, { find: async () => [] }],
  ]);
  return {
    getRepository: (entity: unknown) => repos.get(entity),
  } as unknown as DataSource;
}

describe('GET /physiques/evasion-rate-table/search', () => {
  test('returns the matching physique level for a given evasion rate and HP', async () => {
    const dataSource = mockDataSource({
      evasionRateRows: [
        { level: '1', anntenaCategory: 'A', lineOffset: 0, values: [0, 5, 10] },
      ],
      hpRows: [
        { level: '1', anntenaCategory: 'A', lineOffset: 0, values: [40, 45, 50] },
      ],
    });
    const app = evasionRateTableRoutes(dataSource);

    const response = await app.handle(
      new Request('http://localhost/physiques/evasion-rate-table/search?evasionRate=0&hp=40'),
    );
    const body = await response.json();

    expect(response.status).toBe(200);
    expect(body).toEqual([{ level: '1', anntenaCategory: 'A', lineOffset: 0, columnIndex: 0 }]);
  });

  test('returns an empty array when no row matches both values', async () => {
    const dataSource = mockDataSource({
      evasionRateRows: [{ level: '1', anntenaCategory: 'A', lineOffset: 0, values: [0, 5] }],
      hpRows: [{ level: '1', anntenaCategory: 'A', lineOffset: 0, values: [45, 50] }],
    });
    const app = evasionRateTableRoutes(dataSource);

    const response = await app.handle(
      new Request('http://localhost/physiques/evasion-rate-table/search?evasionRate=0&hp=40'),
    );
    const body = await response.json();

    expect(response.status).toBe(200);
    expect(body).toEqual([]);
  });

  test('returns every matching row when more than one satisfies both values', async () => {
    const dataSource = mockDataSource({
      evasionRateRows: [
        { level: '1', anntenaCategory: 'A', lineOffset: 0, values: [0, 5] },
        { level: '2', anntenaCategory: 'A', lineOffset: 0, values: [0, 3] },
      ],
      hpRows: [
        { level: '1', anntenaCategory: 'A', lineOffset: 0, values: [40, 45] },
        { level: '2', anntenaCategory: 'A', lineOffset: 0, values: [40, 42] },
      ],
    });
    const app = evasionRateTableRoutes(dataSource);

    const response = await app.handle(
      new Request('http://localhost/physiques/evasion-rate-table/search?evasionRate=0&hp=40'),
    );
    const body = await response.json();

    expect(response.status).toBe(200);
    expect(body).toEqual([
      { level: '1', anntenaCategory: 'A', lineOffset: 0, columnIndex: 0 },
      { level: '2', anntenaCategory: 'A', lineOffset: 0, columnIndex: 0 },
    ]);
  });
});
