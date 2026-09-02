import { listObjectsS3, presignGetUrl } from '@Hashibutogarasu/denpa-memo-cloud-data';
import { requireVerifiedUser } from '../auth-context';
import { NotFoundError } from '../http-errors';
import { r2CredentialsFromEnv } from '../r2-credentials';
import type { Env } from '../env';

/**
 * Looks up the caller's uploaded `.dm` file and returns a signed download
 * URL for it. Uses {@link listObjectsS3} (see its doc comment) rather than
 * the native `R2Bucket` binding to find the object.
 */
export function dmFileDownloadHandler(env: Env) {
  return async ({ request, params }: { request: Request; params: { fileId: string } }) => {
    const { uid } = await requireVerifiedUser(request, env);
    const prefix = `${uid}/${params.fileId}/`;
    const credentials = r2CredentialsFromEnv(env);
    const [object] = await listObjectsS3(credentials, prefix);
    if (!object) {
      throw new NotFoundError('cloud file not found');
    }
    const downloadUrl = await presignGetUrl(credentials, object.key);
    const filename = object.key.slice(prefix.length);
    return { downloadUrl, filename, expiresIn: 300 };
  };
}
