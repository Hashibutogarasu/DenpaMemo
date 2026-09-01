import { listObjects, type CloudFileObject } from '@Hashibutogarasu/denpa-memo-cloud-data';
import { requireVerifiedUser } from '../auth-context';
import type { Env } from '../env';

/** Lists every cloud file for the caller. Used for re-sync only — the app's
 * primary path reads its local CloudFilesRepository cache instead. */
export function dmFilesHandler(env: Env) {
  return async ({ request }: { request: Request }) => {
    const { uid } = await requireVerifiedUser(request, env);
    const objects = await listObjects(env.STORAGE, `${uid}/`);
    const files = objects.map((object: CloudFileObject) => {
      const [fileId, ...rest] = object.key.slice(`${uid}/`.length).split('/');
      return { fileId, filename: rest.join('/'), size: object.size, uploaded: object.uploaded };
    });
    return { files };
  };
}
