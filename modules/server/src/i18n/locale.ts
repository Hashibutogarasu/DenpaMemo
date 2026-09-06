/**
 * Single source of truth for which locale this server currently treats
 * as "the" locale, and which locales it can serve at all. Everything
 * that needs a locale — `i18n` package configuration, `Accept-Language`
 * negotiation, GraphQL responses with no per-request locale of their
 * own — reads from here, so adding a locale later is a one-file change
 * instead of a hunt for scattered `'ja'` literals.
 */
export const defaultLocale = 'ja';

export const supportedLocales = [defaultLocale];
