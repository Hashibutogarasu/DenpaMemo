import { supportedLocales } from '../i18n/locale';

/**
 * Picks the best-matching locale out of `supported` from an
 * `Accept-Language` header value (e.g. `"ja,en-US;q=0.8,en;q=0.6"`),
 * falling back to `supported`'s first entry when the header is missing
 * or names nothing supported. Only the primary language subtag (before
 * any `-`) is compared, so `ja-JP` matches a supported `ja`.
 */
export function parseAcceptLanguage(header: string | undefined, supported: string[] = supportedLocales): string {
  const fallback = supported[0];
  if (!header) {
    return fallback;
  }

  const requested = header
    .split(',')
    .map((part) => {
      const [tag, qValue] = part.trim().split(';q=');
      return { tag: tag.split('-')[0].toLowerCase(), quality: qValue ? Number(qValue) : 1 };
    })
    .sort((a, b) => b.quality - a.quality);

  const match = requested.find((entry) => supported.includes(entry.tag));
  return match?.tag ?? fallback;
}
