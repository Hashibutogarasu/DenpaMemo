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
  { statusCategory: 'HP', level: '2', anntenaCategory: 'アンテナ無し', lineOffset: 0, values: [40, 40, 60, 80] },
];

const evasionRows: EvasionRow[] = [
  { level: '1', anntenaCategory: 'アンテナ無し', lineOffset: 0, values: [0, 0, 5, 10] },
  { level: '2', anntenaCategory: 'アンテナ無し', lineOffset: 0, values: [0, 0, 5, 10] },
];

const categoryRows = [
  { evasionRateStart: 0, evasionRateEnd: 0, columnIndex: 0, textKey: 'largest', sign: null },
  { evasionRateStart: 0, evasionRateEnd: 0, columnIndex: 1, textKey: 'large', sign: null },
  { evasionRateStart: 5, evasionRateEnd: 5, columnIndex: 2, textKey: 'medium', sign: null },
  { evasionRateStart: 10, evasionRateEnd: 10, columnIndex: 3, textKey: 'fast', sign: 'plus' },
  { evasionRateStart: 10, evasionRateEnd: 10, columnIndex: 3, textKey: 'fastest', sign: null },
];

function matchesWhere<T>(row: T, where: Partial<T>): boolean {
  return (Object.entries(where) as Array<[keyof T, unknown]>).every(([key, value]) => row[key] === value);
}

/**
 * A plain in-memory stand-in for `DataSource`, mirroring
 * `anntena-convert.test.ts`'s approach so `tablesRoutes` can be
 * black-box tested through real HTTP requests (via `Elysia.handle`)
 * without a real database.
 */
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

function searchUrl(params: Record<string, string>): string {
  return `http://localhost/tables/search?${new URLSearchParams(params).toString()}`;
}

describe('GET /tables/search', () => {
  const app = tablesRoutes(fakeDataSource());

  test('antenna id + level narrows to a single matching column', async () => {
    const response = await app.handle(
      new Request(searchUrl({ antenna: 'none', level: '1', hp: '60', evasionRate: '5' })),
    );
    expect(response.status).toBe(200);
    expect(await response.json()).toEqual({
      matches: [
        {
          level: '1',
          anntenaCategory: 'アンテナ無し',
          lineOffset: 0,
          columnIndex: 2,
          candidates: [{ textKey: 'medium', text: '中間', sign: null, evasionRateStart: 5, evasionRateEnd: 5 }],
        },
      ],
      info: null,
    });
  });

  test('multiple columns matching both hp and evasionRate all come back, each with its own candidates', async () => {
    const response = await app.handle(
      new Request(searchUrl({ antenna: 'none', level: '1', hp: '40', evasionRate: '0' })),
    );
    expect(await response.json()).toEqual({
      matches: [
        {
          level: '1',
          anntenaCategory: 'アンテナ無し',
          lineOffset: 0,
          columnIndex: 0,
          candidates: [{ textKey: 'largest', text: '最大', sign: null, evasionRateStart: 0, evasionRateEnd: 0 }],
        },
        {
          level: '1',
          anntenaCategory: 'アンテナ無し',
          lineOffset: 0,
          columnIndex: 1,
          candidates: [{ textKey: 'large', text: '準大', sign: null, evasionRateStart: 0, evasionRateEnd: 0 }],
        },
      ],
      info: null,
    });
  });

  test('overlapping category patterns return every candidate for the user to choose between', async () => {
    const response = await app.handle(
      new Request(searchUrl({ antenna: 'none', level: '1', hp: '80', evasionRate: '10' })),
    );
    expect(await response.json()).toEqual({
      matches: [
        {
          level: '1',
          anntenaCategory: 'アンテナ無し',
          lineOffset: 0,
          columnIndex: 3,
          candidates: [
            { textKey: 'fast', text: '準速', sign: 'plus', evasionRateStart: 10, evasionRateEnd: 10 },
            { textKey: 'fastest', text: '最速', sign: null, evasionRateStart: 10, evasionRateEnd: 10 },
          ],
        },
      ],
      info: null,
    });
  });

  test('an unmatched search returns an empty matches list plus a debug info dump', async () => {
    const response = await app.handle(
      new Request(searchUrl({ antenna: 'none', level: '1', hp: '999', evasionRate: '999' })),
    );
    const body = (await response.json()) as { matches: unknown[]; info: unknown };
    expect(body.matches).toEqual([]);
    expect(body.info).not.toBeNull();
  });

  test('an unknown antenna id returns a 404 not found error', async () => {
    const response = await app.handle(
      new Request(searchUrl({ antenna: 'unknown_antenna', level: '1', hp: '40', evasionRate: '0' })),
    );
    expect(response.status).toBe(404);
  });

  test('anntenaCategory still works without an antenna id (regression)', async () => {
    const response = await app.handle(
      new Request(searchUrl({ anntenaCategory: 'アンテナ無し', level: '1', hp: '40', evasionRate: '0' })),
    );
    expect(response.status).toBe(200);
    expect(await response.json()).toEqual({
      matches: [
        {
          level: '1',
          anntenaCategory: 'アンテナ無し',
          lineOffset: 0,
          columnIndex: 0,
          candidates: [{ textKey: 'largest', text: '最大', sign: null, evasionRateStart: 0, evasionRateEnd: 0 }],
        },
        {
          level: '1',
          anntenaCategory: 'アンテナ無し',
          lineOffset: 0,
          columnIndex: 1,
          candidates: [{ textKey: 'large', text: '準大', sign: null, evasionRateStart: 0, evasionRateEnd: 0 }],
        },
      ],
      info: null,
    });
  });

  test('level filters out rows from other levels', async () => {
    const response = await app.handle(
      new Request(searchUrl({ antenna: 'none', level: '2', hp: '40', evasionRate: '0' })),
    );
    const body = (await response.json()) as { matches: Array<{ level: string }> };
    expect(body.matches.every((row) => row.level === '2')).toBe(true);
  });
});
