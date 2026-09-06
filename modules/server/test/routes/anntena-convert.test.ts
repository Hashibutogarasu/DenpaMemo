import { describe, expect, test } from 'vitest';
import type { DataSource } from 'typeorm';
import type { AnntenaEntity } from '../../src/entities/anntena.entity';
import { AnntenaEntity as AnntenaEntityClass } from '../../src/entities/anntena.entity';
import type { MinorCategoryEntity } from '../../src/entities/minor-category.entity';
import { MinorCategoryEntity as MinorCategoryEntityClass } from '../../src/entities/minor-category.entity';
import type { PhysiqueAntennaCategoryAntennaEntity } from '../../src/entities/physique-antenna-category-antenna.entity';
import { PhysiqueAntennaCategoryAntennaEntity as PhysiqueAntennaCategoryAntennaEntityClass } from '../../src/entities/physique-antenna-category-antenna.entity';
import type { TranslationEntity } from '../../src/entities/translation.entity';
import { TranslationEntity as TranslationEntityClass } from '../../src/entities/translation.entity';
import { anntenaRoutes } from '../../src/routes/anntena.route';

const noneMinorCategory = { id: 'none', majorCategoryId: 'none' } as MinorCategoryEntity;
const healSoloMinorCategory = { id: 'heal_solo', majorCategoryId: 'healing' } as MinorCategoryEntity;
const attackAllMinorCategory = { id: 'attack_all', majorCategoryId: 'attack' } as MinorCategoryEntity;

const noneAnntena = { id: 'none' } as AnntenaEntity;
const healSoloAnntena = { id: 'heal_solo_1' } as AnntenaEntity;
const fireballAllAnntena = { id: 'fireball_all' } as AnntenaEntity;

const translations = [
  { entityType: 'antenna', entityLegacyId: 'heal_solo_1', locale: 'ja', value: 'ちょっとかいふく' },
  { entityType: 'antenna', entityLegacyId: 'fireball_all', locale: 'ja', value: 'やまかじ' },
  { entityType: 'antenna', entityLegacyId: 'none', locale: 'ja', value: 'アンテナなし' },
] as TranslationEntity[];

const links = [
  {
    id: 'link-1',
    minorCategoryId: 'heal_solo',
    anntenaId: 'heal_solo_1',
    minorCategory: healSoloMinorCategory,
    anntena: healSoloAnntena,
  },
  {
    id: 'link-2',
    minorCategoryId: 'attack_all',
    anntenaId: 'fireball_all',
    minorCategory: attackAllMinorCategory,
    anntena: fireballAllAnntena,
  },
  {
    id: 'link-3',
    minorCategoryId: 'none',
    anntenaId: 'none',
    minorCategory: noneMinorCategory,
    anntena: noneAnntena,
  },
] as PhysiqueAntennaCategoryAntennaEntity[];

const minorCategories = [noneMinorCategory, healSoloMinorCategory, attackAllMinorCategory];
const anntenas = [noneAnntena, healSoloAnntena, fireballAllAnntena];

/**
 * A plain in-memory stand-in for `DataSource`, so `anntenaRoutes` can be
 * black-box tested through real HTTP requests (via `Elysia.handle`)
 * without a real database.
 */
function fakeDataSource(): DataSource {
  const repositories = new Map<unknown, unknown>([
    [
      MinorCategoryEntityClass,
      {
        findOneBy: async ({ id }: Partial<MinorCategoryEntity>) =>
          minorCategories.find((category) => category.id === id) ?? null,
      },
    ],
    [
      AnntenaEntityClass,
      {
        findOneBy: async ({ id }: Partial<AnntenaEntity>) => anntenas.find((anntena) => anntena.id === id) ?? null,
      },
    ],
    [
      TranslationEntityClass,
      {
        findOneBy: async (where: Partial<TranslationEntity>) =>
          translations.find((translation) =>
            Object.entries(where).every(
              ([key, value]) => translation[key as keyof TranslationEntity] === value,
            ),
          ) ?? null,
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

function convertUrl(params: Record<string, string>): string {
  return `http://localhost/anntena/convert?${new URLSearchParams(params).toString()}`;
}

describe('GET /anntena/convert', () => {
  const app = anntenaRoutes(fakeDataSource());

  test('category (id) -> specific (translated): minor category "none" resolves to the "アンテナなし" antenna', async () => {
    const response = await app.handle(
      new Request(
        convertUrl({ from: 'category', to: 'specific', inputFormat: 'id', outputFormat: 'translated', input: 'none' }),
        { headers: { 'accept-language': 'ja' } },
      ),
    );
    expect(response.status).toBe(200);
    expect(await response.json()).toEqual(['アンテナなし']);
  });

  test('specific (translated) -> category (translated): "やまかじ" resolves to major "攻撃系" / minor "全体攻撃"', async () => {
    const response = await app.handle(
      new Request(
        convertUrl({
          from: 'specific',
          to: 'category',
          inputFormat: 'translated',
          outputFormat: 'translated',
          input: 'やまかじ',
        }),
        { headers: { 'accept-language': 'ja' } },
      ),
    );
    expect(response.status).toBe(200);
    expect(await response.json()).toEqual({ major: '攻撃系', minor: '全体攻撃' });
  });

  test('specific (translated) -> category (id): "やまかじ" resolves to the "attack"/"attack_all" ids', async () => {
    const response = await app.handle(
      new Request(
        convertUrl({
          from: 'specific',
          to: 'category',
          inputFormat: 'translated',
          outputFormat: 'id',
          input: 'やまかじ',
        }),
        { headers: { 'accept-language': 'ja' } },
      ),
    );
    expect(response.status).toBe(200);
    expect(await response.json()).toEqual({ majorCategoryId: 'attack', minorCategoryId: 'attack_all' });
  });

  test('category (translated) -> specific (id): "単体回復" resolves to the "heal_solo_1" antenna', async () => {
    const response = await app.handle(
      new Request(
        convertUrl({
          from: 'category',
          to: 'specific',
          inputFormat: 'translated',
          outputFormat: 'id',
          input: '単体回復',
        }),
        { headers: { 'accept-language': 'ja' } },
      ),
    );
    expect(response.status).toBe(200);
    expect(await response.json()).toEqual(['heal_solo_1']);
  });

  test('unknown minor category id returns a 404 not found error', async () => {
    const response = await app.handle(
      new Request(
        convertUrl({
          from: 'category',
          to: 'specific',
          inputFormat: 'id',
          outputFormat: 'id',
          input: 'unknown_category',
        }),
      ),
    );
    expect(response.status).toBe(404);
  });

  test('from and to must differ', async () => {
    const response = await app.handle(
      new Request(
        convertUrl({
          from: 'category',
          to: 'category',
          inputFormat: 'id',
          outputFormat: 'id',
          input: 'none',
        }),
      ),
    );
    expect(response.status).toBe(422);
  });
});
