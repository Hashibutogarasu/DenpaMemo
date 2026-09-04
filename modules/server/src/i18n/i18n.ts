import path from 'node:path';
import i18n from 'i18n';

i18n.configure({
  locales: ['ja'],
  directory: path.resolve(import.meta.dirname, '..', '..', 'locales'),
  objectNotation: true,
  updateFiles: false,
});

/** One locale's `major_category`/`minor_category` translation maps, as stored in `locales/<locale>.json`. */
interface CategoryCatalog {
  major_category?: Record<string, string>;
  minor_category?: Record<string, string>;
}

function categoryCatalog(locale: string): CategoryCatalog {
  return i18n.getCatalog(locale) as CategoryCatalog;
}

/** Translates a major category id, or `undefined` if the locale has no entry for it. */
export function translateMajorCategory(id: string, locale: string): string | undefined {
  return categoryCatalog(locale).major_category?.[id];
}

/** Translates a minor category id, or `undefined` if the locale has no entry for it. */
export function translateMinorCategory(id: string, locale: string): string | undefined {
  return categoryCatalog(locale).minor_category?.[id];
}

/** Reverse lookup: the major category id whose translation in `locale` equals `value`, if any. */
export function findMajorCategoryIdByTranslation(value: string, locale: string): string | undefined {
  const catalog = categoryCatalog(locale).major_category ?? {};
  return Object.keys(catalog).find((id) => catalog[id] === value);
}

/** Reverse lookup: the minor category id whose translation in `locale` equals `value`, if any. */
export function findMinorCategoryIdByTranslation(value: string, locale: string): string | undefined {
  const catalog = categoryCatalog(locale).minor_category ?? {};
  return Object.keys(catalog).find((id) => catalog[id] === value);
}
