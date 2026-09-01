import { Elysia } from 'elysia';
import { accountDeleteHandler } from './routes/account-delete';
import { dmFileDeleteHandler } from './routes/dmfile-delete';
import { dmFileDownloadHandler } from './routes/dmfile-download';
import { dmFileLinkHandler } from './routes/dmfile-link';
import { dmFilesHandler } from './routes/dmfiles';
import { HttpError } from './http-errors';
import type { Env } from './env';

/**
 * Builds a fresh Elysia app bound to [env]. Cloudflare Workers passes
 * `env` as a per-request `fetch` argument rather than a process global,
 * so this is called once per request from the Worker's own `fetch`
 * handler (see index.ts) instead of being constructed at module scope.
 */
export function buildApp(env: Env) {
  return new Elysia({ aot: false })
    .onError(({ error, set }) => {
      if (error instanceof HttpError) {
        set.status = error.status;
        return { error: error.message, code: error.code };
      }
      set.status = 500;
      return { error: 'internal error', code: 'internal_error' };
    })
    .get('/dmfile/link', dmFileLinkHandler(env))
    .get('/dmfile/download/:fileId', dmFileDownloadHandler(env))
    .get('/dmfiles', dmFilesHandler(env))
    .delete('/dmfile', dmFileDeleteHandler(env))
    .delete('/account', accountDeleteHandler(env));
}
