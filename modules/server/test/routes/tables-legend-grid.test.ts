import { describe, expect, test } from 'vitest';
import type { DataSource } from 'typeorm';
import type { AnntenaEntity } from '../../src/entities/anntena.entity';
import { AnntenaEntity as AnntenaEntityClass } from '../../src/entities/anntena.entity';
import type { MinorCategoryEntity } from '../../src/entities/minor-category.entity';
import { MinorCategoryEntity as MinorCategoryEntityClass } from '../../src/entities/minor-category.entity';
import { PhysiqueAntennaCategoryEntity } from '../../src/entities/physique-antenna-category.entity';
import type { PhysiqueAntennaCategoryAntennaEntity } from '../../src/entities/physique-antenna-category-antenna.entity';
import { PhysiqueAntennaCategoryAntennaEntity as PhysiqueAntennaCategoryAntennaEntityClass } from '../../src/entities/physique-antenna-category-antenna.entity';
import { PhysiqueEvasionRateCategoryEntity } from '../../src/entities/physique-evasion-rate-category.entity';
import { PhysiqueEvasionRateTableEntity } from '../../src/entities/physique-evasion-rate-table.entity';
import { PhysiqueTableEntity } from '../../src/entities/physique-table.entity';
import { TableDefinitionEntity } from '../../src/entities/table-definition.entity';
import type { TranslationEntity } from '../../src/entities/translation.entity';
import { TranslationEntity as TranslationEntityClass } from '../../src/entities/translation.entity';
import { tablesRoutes } from '../../src/routes/tables.route';

const noneMinorCategory = { id: 'none', majorCategoryId: 'none' } as MinorCategoryEntity;
const noneAnntena = { id: 'none' } as AnntenaEntity;
const links = [
  {
    id: 'link-1',
    minorCategoryId: 'none',
    anntenaId: 'none',
    minorCategory: noneMinorCategory,
    anntena: noneAnntena,
  },
] as PhysiqueAntennaCategoryAntennaEntity[];

const tableDefinitions = [
  { type: 'hp', columnCount: 4, translationKey: 'stat.hp' },
  { type: 'evasionRate', columnCount: 4, translationKey: 'stat.evasionRate' },
];

interface HpRow {
  statusCategory: string;
  level: string;
  anntenaCategory: string;
  lineOffset: number;
  values: Array<number | null>;
}

interface EvasionRow {
  level: string;
  anntenaCategory: string;
  lineOffset: number;
  values: Array<number | null>;
}

const hpRows: HpRow[] = [
  { statusCategory: 'HP', level: '1', anntenaCategory: 'アンテナ無し', lineOffset: 0, values: [40, 40, 60, 80] },
];

const evasionRows: EvasionRow[] = [
  { level: '1', anntenaCategory: 'アンテナ無し', lineOffset: 0, values: [0, 0, 5, 10] },
];

const categoryRows = [
  { id: 'a', evasionRateStart: 0, evasionRateEnd: 0, columnIndex: 0, textKey: 'largest', sign: null },
  { id: 'b', evasionRateStart: 0, evasionRateEnd: 0, columnIndex: 1, textKey: 'large', sign: null },
  { id: 'c', evasionRateStart: 5, evasionRateEnd: 5, columnIndex: 2, textKey: 'medium', sign: null },
  { id: 'd', evasionRateStart: 10, evasionRateEnd: 10, columnIndex: 3, textKey: 'fast', sign: 'plus' },
  { id: 'e', evasionRateStart: 10, evasionRateEnd: 10, columnIndex: 3, textKey: 'fastest', sign: null },
];

function matchesWhere<T>(row: T, where: Partial<T>): boolean {
  return (Object.entries(where) as Array<[keyof T, unknown]>).every(([key, value]) => row[key] === value);
}

function fakeDataSource(): DataSource {
  const repositories = new Map<unknown, unknown>([
    [
      TableDefinitionEntity,
      {
        find: async () => tableDefinitions,
        findOne: async ({ where: { type } }: { where: { type: string } }) =>
          tableDefinitions.find((definition) => definition.type === type) ?? null,
      },
    ],
    [
      PhysiqueTableEntity,
      {
        find: async ({ where }: { where: Partial<HpRow> }) => hpRows.filter((row) => matchesWhere(row, where)),
      },
    ],
    [
      PhysiqueEvasionRateTableEntity,
      {
        find: async ({ where }: { where: Partial<EvasionRow> }) =>
          evasionRows.filter((row) => matchesWhere(row, where)),
      },
    ],
    [
      PhysiqueAntennaCategoryEntity,
      {
        find: async () => [],
      },
    ],
    [
      PhysiqueEvasionRateCategoryEntity,
      {
        find: async () => categoryRows,
      },
    ],
    [
      MinorCategoryEntityClass,
      {
        findOneBy: async ({ id }: Partial<MinorCategoryEntity>) =>
          noneMinorCategory.id === id ? noneMinorCategory : null,
      },
    ],
    [
      AnntenaEntityClass,
      {
        findOneBy: async ({ id }: Partial<AnntenaEntity>) => (noneAnntena.id === id ? noneAnntena : null),
      },
    ],
    [
      TranslationEntityClass,
      {
        findOneBy: async (_where: Partial<TranslationEntity>) => null,
      },
    ],
    [
      PhysiqueAntennaCategoryAntennaEntityClass,
      {
        find: async ({ where }: { where: Partial<PhysiqueAntennaCategoryAntennaEntity> }) =>
          links.filter((link) => link.minorCategoryId === where.minorCategoryId),
        findOneBy: async ({ anntenaId }: Partial<PhysiqueAntennaCategoryAntennaEntity>) =>
          links.find((link) => link.anntenaId === anntenaId) ?? null,
      },
    ],
  ]);

  return {
    getRepository: (entity: unknown) => repositories.get(entity),
  } as unknown as DataSource;
}

function legendGridUrl(params: Record<string, string>): string {
  return `http://localhost/tables/legend-grid?${new URLSearchParams(params).toString()}`;
}

describe('GET /tables/legend-grid', () => {
  const app = tablesRoutes(fakeDataSource());

  test('returns legend cells (with liveValues/isMatch) and hp cells for a level/anntenaCategory pair', async () => {
    const response = await app.handle(
      new Request(
        legendGridUrl({
          level: '1',
          anntenaCategory: 'アンテナ無し',
          matchColumnIndex: '2',
          matchLineOffset: '0',
          matchEvasionRate: '5',
        }),
      ),
    );
    expect(response.status).toBe(200);
    const body = (await response.json()) as {
      level: string;
      anntenaCategory: string;
      legendCells: Array<Record<string, unknown>>;
      hpCells: Array<Record<string, unknown>>;
    };
    expect(body.level).toBe('1');
    expect(body.anntenaCategory).toBe('アンテナ無し');
    expect(body.legendCells).toContainEqual({
      categoryId: 'c',
      evasionRateStart: 5,
      evasionRateEnd: 5,
      columnIndex: 2,
      textKey: 'medium',
      text: '中間',
      sign: null,
      liveValues: [5],
      isMatch: true,
    });
    expect(body.hpCells).toContainEqual({ columnIndex: 2, lineOffset: 0, value: 60, isMatch: true });
    expect(body.hpCells.filter((cell) => cell.isMatch)).toHaveLength(1);
  });

  test('resolves anntenaCategory from an antenna id, mirroring /search', async () => {
    const response = await app.handle(
      new Request(
        legendGridUrl({
          level: '1',
          antenna: 'none',
          matchColumnIndex: '0',
          matchLineOffset: '0',
          matchEvasionRate: '0',
        }),
      ),
    );
    expect(response.status).toBe(200);
    const body = (await response.json()) as { anntenaCategory: string };
    expect(body.anntenaCategory).toBe('アンテナ無し');
  });

  test('400s when neither anntenaCategory nor antenna is given', async () => {
    const response = await app.handle(
      new Request(
        legendGridUrl({
          level: '1',
          matchColumnIndex: '0',
          matchLineOffset: '0',
          matchEvasionRate: '0',
        }),
      ),
    );
    expect(response.status).toBe(400);
  });
});
