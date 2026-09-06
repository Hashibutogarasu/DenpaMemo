import { Elysia } from 'elysia';
import type { DataSource } from 'typeorm';
import type { z } from 'zod';
import { AntennaCategoryLinkDataSource } from '../domain/physique/antenna-category-link-data-source';
import { parseAcceptLanguage } from '../http/accept-language';
import { categoryTranslator } from '../i18n/i18n';
import { AnntenaEntity } from '../entities/anntena.entity';
import { MinorCategoryEntity } from '../entities/minor-category.entity';
import { PhysiqueAntennaCategoryAntennaEntity } from '../entities/physique-antenna-category-antenna.entity';
import { TranslationEntity } from '../entities/translation.entity';
import { convertQuerySchema } from './anntena.schema';

function zodErrorResponse(error: z.ZodError) {
  return { error: 'validation_error', issues: error.issues };
}

function notFoundResponse(message: string) {
  return { error: 'validation_error', issues: [{ message, path: ['input'] }] };
}

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
    app.get('/convert', async ({ query, set, headers }) => {
      const parsed = convertQuerySchema.safeParse(query);
      if (!parsed.success) {
        set.status = 400;
        return zodErrorResponse(parsed.error);
      }
      const { from, to, inputFormat, outputFormat, input } = parsed.data;
      const locale = parseAcceptLanguage(headers['accept-language']);

      let minorCategory: MinorCategoryEntity | null = null;
      let anntena: AnntenaEntity | null = null;

      if (from === 'category') {
        const minorCategoryId =
          inputFormat === 'id' ? input : categoryTranslator.findMinorCategoryIdByTranslation(input, locale);
        if (!minorCategoryId) {
          set.status = 400;
          return notFoundResponse(`No minor category found for "${input}"`);
        }
        minorCategory = await linkDataSource.findMinorCategoryById(minorCategoryId);
        if (!minorCategory) {
          set.status = 400;
          return notFoundResponse(`No minor category found for "${input}"`);
        }
      } else {
        const legacyId =
          inputFormat === 'id'
            ? input
            : await linkDataSource.findAntennaLegacyIdByTranslatedName(input, locale);
        if (!legacyId) {
          set.status = 400;
          return notFoundResponse(`No antenna found for "${input}"`);
        }
        anntena = await linkDataSource.findAntennaByLegacyId(legacyId);
        if (!anntena) {
          set.status = 400;
          return notFoundResponse(`No antenna found for "${input}"`);
        }
      }

      if (to === 'specific') {
        const links = await linkDataSource.findLinksForMinorCategory(minorCategory!.id);
        if (outputFormat === 'id') {
          return links.map((link) => link.anntena.legacyId);
        }
        const names = await Promise.all(
          links.map((link) => linkDataSource.findAntennaTranslatedName(link.anntena.legacyId, locale)),
        );
        return names.filter((name): name is string => name !== undefined);
      }

      const link = await linkDataSource.findLinkForAntenna(anntena!.id);
      if (!link) {
        set.status = 400;
        return notFoundResponse(`No category linked to "${input}"`);
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
        set.status = 400;
        return notFoundResponse(`No "${locale}" translation for category linked to "${input}"`);
      }
      return { major, minor };
    }),
  );
}
