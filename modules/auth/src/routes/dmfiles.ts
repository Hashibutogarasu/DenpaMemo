import { listObjectsS3, type CloudFileObject } from '@Hashibutogarasu/denpa-memo-cloud-data';
import { requireVerifiedUser } from '../auth-context';
import { r2CredentialsFromEnv } from '../r2-credentials';
import type { Env } from '../env';

/**
 * Lists every cloud file for the caller, so the app can reconcile its
 * local `CloudFilesRepository` cache against the account's actual state
 * (e.g. on a device that never uploaded from, but shares the account
 * with, another device that did).
 */
export function dmFilesHandler(env: Env) {
  return async ({ request }: { request: Request }) => {
    const { uid } = await requireVerifiedUser(request, env);
    const objects = await listObjectsS3(r2CredentialsFromEnv(env), `${uid}/`);
    const files = objects.map((object: CloudFileObject) => {
      const [fileId, ...rest] = object.key.slice(`${uid}/`.length).split('/');
      return { fileId, filename: rest.join('/'), size: object.size, uploaded: object.uploaded };
    });
    return { files };
  };
}
