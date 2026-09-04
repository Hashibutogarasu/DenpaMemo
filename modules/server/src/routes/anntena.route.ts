import { Elysia } from 'elysia';
import type { DataSource } from 'typeorm';
import { AntennaCategoryLinkDataSource } from '../domain/physique/antenna-category-link-data-source';
import { parseAcceptLanguage } from '../http/accept-language';
import { categoryTranslator } from '../i18n/i18n';
import { AnntenaEntity } from '../entities/anntena.entity';
import { MinorCategoryEntity } from '../entities/minor-category.entity';
import { PhysiqueAntennaCategoryAntennaEntity } from '../entities/physique-antenna-category-antenna.entity';
import { TranslationEntity } from '../entities/translation.entity';
import type { ConvertFormat, ConvertSide } from './anntena.schema';
import { convertQuerySchema } from './anntena.schema';

function notFoundResponse(message: string) {
  return { error: 'validation_error', issues: [{ message, path: ['input'] }] };
}

/** The result of a resolution step: either the resolved `value`, or a `message` explaining why it failed. */
type Resolution<T> = { ok: true; value: T } | { ok: false; message: string };

function ok<T>(value: T): Resolution<T> {
  return { ok: true, value };
}

function notFound<T>(message: string): Resolution<T> {
  return { ok: false, message };
}

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
  ): Promise<Resolution<FromResolution>>;
}

const fromResolvers: Record<ConvertSide, FromResolver> = {
  category: {
    async resolve(linkDataSource, input, inputFormat, locale) {
      const minorCategoryId =
        inputFormat === 'id' ? input : categoryTranslator.findMinorCategoryIdByTranslation(input, locale);
      if (!minorCategoryId) {
        return notFound(`No minor category found for "${input}"`);
      }
      const minorCategory = await linkDataSource.findMinorCategoryById(minorCategoryId);
      if (!minorCategory) {
        return notFound(`No minor category found for "${input}"`);
      }
      return ok({ minorCategory });
    },
  },
  specific: {
    async resolve(linkDataSource, input, inputFormat, locale) {
      const antennaId = inputFormat === 'id' ? input : await linkDataSource.findAntennaIdByTranslatedName(input, locale);
      if (!antennaId) {
        return notFound(`No antenna found for "${input}"`);
      }
      const anntena = await linkDataSource.findAntennaById(antennaId);
      if (!anntena) {
        return notFound(`No antenna found for "${input}"`);
      }
      return ok({ anntena });
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
  ): Promise<Resolution<unknown>>;
}

const toResolvers: Record<ConvertSide, ToResolver> = {
  specific: {
    async resolve(linkDataSource, { minorCategory }, outputFormat, locale) {
      const links = await linkDataSource.findLinksForMinorCategory(minorCategory!.id);
      if (outputFormat === 'id') {
        return ok(links.map((link) => link.anntena.id));
      }
      const names = await Promise.all(
        links.map((link) => linkDataSource.findAntennaTranslatedName(link.anntena.id, locale)),
      );
      return ok(names.filter((name): name is string => name !== undefined));
    },
  },
  category: {
    async resolve(linkDataSource, { anntena }, outputFormat, locale, input) {
      const link = await linkDataSource.findLinkForAntenna(anntena!.id);
      if (!link) {
        return notFound(`No category linked to "${input}"`);
      }
      if (outputFormat === 'id') {
        return ok({
          majorCategoryId: link.minorCategory.majorCategoryId,
          minorCategoryId: link.minorCategoryId,
        });
      }
      const major = categoryTranslator.translateMajorCategory(link.minorCategory.majorCategoryId, locale);
      const minor = categoryTranslator.translateMinorCategory(link.minorCategoryId, locale);
      if (major === undefined || minor === undefined) {
        return notFound(`No "${locale}" translation for category linked to "${input}"`);
      }
      return ok({ major, minor });
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
  const linkDataSource = new AntennaCategoryLinkDataSource(
    dataSource.getRepository(MinorCategoryEntity),
    dataSource.getRepository(AnntenaEntity),
    dataSource.getRepository(TranslationEntity),
    dataSource.getRepository(PhysiqueAntennaCategoryAntennaEntity),
  );

  return new Elysia().group('/anntena', (app) =>
    app.get(
      '/convert',
      async ({ query: { from, to, inputFormat, outputFormat, input }, set, headers }) => {
        const locale = parseAcceptLanguage(headers['accept-language']);

        const resolved = await fromResolvers[from].resolve(linkDataSource, input, inputFormat, locale);
        if (!resolved.ok) {
          set.status = 400;
          return notFoundResponse(resolved.message);
        }

        const result = await toResolvers[to].resolve(linkDataSource, resolved.value, outputFormat, locale, input);
        if (!result.ok) {
          set.status = 400;
          return notFoundResponse(result.message);
        }
        return result.value;
      },
      { query: convertQuerySchema },
    ),
  );
}
