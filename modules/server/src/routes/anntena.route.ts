import { Elysia, NotFoundError } from 'elysia';
import type { DataSource } from 'typeorm';
import {
  createAntennaCategoryLinkDataSource,
  type AntennaCategoryLinkDataSource,
} from '../domain/physique/antenna-category-link-data-source';
import { parseAcceptLanguage } from '../http/accept-language';
import { categoryTranslator } from '../i18n/i18n';
import type { AnntenaEntity } from '../entities/anntena.entity';
import type { MinorCategoryEntity } from '../entities/minor-category.entity';
import type { ConvertFormat, ConvertSide } from './anntena.schema';
import { convertQuerySchema } from './anntena.schema';

interface FromResolution {
  minorCategory?: MinorCategoryEntity;
  anntena?: AnntenaEntity;
}

/** One way of resolving `from`/`input` into either a minor category or an antenna. */
interface FromResolver {
  resolve(
    linkDataSource: AntennaCategoryLinkDataSource,
    input: string,
    inputFormat: ConvertFormat,
    locale: string,
  ): Promise<FromResolution>;
}

const fromResolvers: Record<ConvertSide, FromResolver> = {
  category: {
    async resolve(linkDataSource, input, inputFormat, locale) {
      const minorCategoryId =
        inputFormat === 'id' ? input : categoryTranslator.findMinorCategoryIdByTranslation(input, locale);
      if (!minorCategoryId) {
        throw new NotFoundError(`No minor category found for "${input}"`);
      }
      const minorCategory = await linkDataSource.findMinorCategoryById(minorCategoryId);
      if (!minorCategory) {
        throw new NotFoundError(`No minor category found for "${input}"`);
      }
      return { minorCategory };
    },
  },
  specific: {
    async resolve(linkDataSource, input, inputFormat, locale) {
      const antennaId = inputFormat === 'id' ? input : await linkDataSource.findAntennaIdByTranslatedName(input, locale);
      if (!antennaId) {
        throw new NotFoundError(`No antenna found for "${input}"`);
      }
      const anntena = await linkDataSource.findAntennaById(antennaId);
      if (!anntena) {
        throw new NotFoundError(`No antenna found for "${input}"`);
      }
      return { anntena };
    },
  },
};

/** One way of producing the `to`/`outputFormat` response from a resolved `from`. */
interface ToResolver {
  resolve(
    linkDataSource: AntennaCategoryLinkDataSource,
    resolved: FromResolution,
    outputFormat: ConvertFormat,
    locale: string,
    input: string,
  ): Promise<unknown>;
}

const toResolvers: Record<ConvertSide, ToResolver> = {
  specific: {
    async resolve(linkDataSource, { minorCategory }, outputFormat, locale) {
      const links = await linkDataSource.findLinksForMinorCategory(minorCategory!.id);
      if (outputFormat === 'id') {
        return links.map((link) => link.anntena.id);
      }
      const names = await Promise.all(
        links.map((link) => linkDataSource.findAntennaTranslatedName(link.anntena.id, locale)),
      );
      return names.filter((name): name is string => name !== undefined);
    },
  },
  category: {
    async resolve(linkDataSource, { anntena }, outputFormat, locale, input) {
      const link = await linkDataSource.findLinkForAntenna(anntena!.id);
      if (!link) {
        throw new NotFoundError(`No category linked to "${input}"`);
      }
      if (outputFormat === 'id') {
        return {
          majorCategoryId: link.minorCategory.majorCategoryId,
          minorCategoryId: link.minorCategoryId,
        };
      }
      const major = categoryTranslator.translateMajorCategory(link.minorCategory.majorCategoryId, locale);
      const minor = categoryTranslator.translateMinorCategory(link.minorCategoryId, locale);
      if (major === undefined || minor === undefined) {
        throw new NotFoundError(`No "${locale}" translation for category linked to "${input}"`);
      }
      return { major, minor };
    },
  },
};

/**
 * Generic REST conversion between a physique antenna category (major +
 * minor) and the concrete antennas linked to it, in either direction.
 * `inputFormat`/`outputFormat` are explicit rather than inferred from
 * `from`/`to`, so a caller never has to guess whether a value is an
 * English-word id or a translated display string. Major/minor category
 * translation goes through the server's `i18n` package
 * (`src/i18n/i18n.ts`); antenna translation goes through
 * `AntennaCategoryLinkDataSource`, backed by the existing
 * `TranslationEntity` mechanism, unchanged.
 */
export function anntenaRoutes(dataSource: DataSource) {
  const linkDataSource = createAntennaCategoryLinkDataSource(dataSource);

  return new Elysia().group('/anntena', (app) =>
    app.get(
      '/convert',
      async ({ query: { from, to, inputFormat, outputFormat, input }, headers }) => {
        const locale = parseAcceptLanguage(headers['accept-language']);
        const resolved = await fromResolvers[from].resolve(linkDataSource, input, inputFormat, locale);
        return toResolvers[to].resolve(linkDataSource, resolved, outputFormat, locale, input);
      },
      { query: convertQuerySchema },
    ),
  );
}
