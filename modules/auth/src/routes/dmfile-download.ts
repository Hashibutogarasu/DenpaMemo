import { listObjects, presignGetUrl } from '@Hashibutogarasu/denpa-memo-cloud-data';
import { requireVerifiedUser } from '../auth-context';
import { NotFoundError } from '../http-errors';
import { r2CredentialsFromEnv } from '../r2-credentials';
import type { Env } from '../env';

export function dmFileDownloadHandler(env: Env) {
  return async ({ request, params }: { request: Request; params: { fileId: string } }) => {
    const { uid } = await requireVerifiedUser(request, env);
    const prefix = `${uid}/${params.fileId}/`;
    const [object] = await listObjects(env.STORAGE, prefix);
    if (!object) {
      throw new NotFoundError('cloud file not found');
    }
    const downloadUrl = await presignGetUrl(r2CredentialsFromEnv(env), object.key);
    const filename = object.key.slice(prefix.length);
    return { downloadUrl, filename, expiresIn: 300 };
  };
}
