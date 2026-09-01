import { presignPutUrl } from '@Hashibutogarasu/denpa-memo-cloud-data';
import { createId } from '@paralleldrive/cuid2';
import { requireVerifiedUser } from '../auth-context';
import { BadRequestError } from '../http-errors';
import { r2CredentialsFromEnv } from '../r2-credentials';
import type { Env } from '../env';

export function dmFileLinkHandler(env: Env) {
  return async ({ request, query }: { request: Request; query: Record<string, string | undefined> }) => {
    const { uid } = await requireVerifiedUser(request, env);
    const filename = query.filename;
    if (typeof filename !== 'string' || filename.length === 0) {
      throw new BadRequestError('filename query parameter is required');
    }
    const fileId = createId();
    const key = `${uid}/${fileId}/${filename}`;
    const uploadUrl = await presignPutUrl(r2CredentialsFromEnv(env), key);
    return { uploadUrl, fileId, filename, expiresIn: 300 };
  };
}
