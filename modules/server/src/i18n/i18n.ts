import path from 'node:path';
import i18n from 'i18n';
import { supportedLocales } from './locale';

/** One locale's `major_category`/`minor_category` translation maps, as stored in `locales/<locale>.json`. */
interface CategoryCatalog {
  major_category?: Record<string, string>;
  minor_category?: Record<string, string>;
}

/**
 * Wraps the `i18n` package for the server's own translation needs
 * (currently the physique antenna major/minor categories), configuring
 * it once at construction and exposing lookup/reverse-lookup methods so
 * callers never touch the `i18n` package directly.
 */
export class CategoryTranslator {
  constructor() {
    i18n.configure({
      locales: supportedLocales,
      directory: path.resolve(import.meta.dirname, '..', '..', 'locales'),
      objectNotation: true,
      updateFiles: false,
    });
  }

  /** Translates a major category id, or `undefined` if the locale has no entry for it. */
  translateMajorCategory(id: string, locale: string): string | undefined {
    return this.catalog(locale).major_category?.[id];
  }

  /** Translates a minor category id, or `undefined` if the locale has no entry for it. */
  translateMinorCategory(id: string, locale: string): string | undefined {
    return this.catalog(locale).minor_category?.[id];
  }

  /** Reverse lookup: the major category id whose translation in `locale` equals `value`, if any. */
  findMajorCategoryIdByTranslation(value: string, locale: string): string | undefined {
    const catalog = this.catalog(locale).major_category ?? {};
    return Object.keys(catalog).find((id) => catalog[id] === value);
  }

  /** Reverse lookup: the minor category id whose translation in `locale` equals `value`, if any. */
  findMinorCategoryIdByTranslation(value: string, locale: string): string | undefined {
    const catalog = this.catalog(locale).minor_category ?? {};
    return Object.keys(catalog).find((id) => catalog[id] === value);
  }

  private catalog(locale: string): CategoryCatalog {
    return i18n.getCatalog(locale) as CategoryCatalog;
  }
}

export const categoryTranslator = new CategoryTranslator();
