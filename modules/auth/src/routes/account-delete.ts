import { deleteFolder } from '@Hashibutogarasu/denpa-memo-cloud-data';
import { requireVerifiedUser } from '../auth-context';
import type { Env } from '../env';

/** Deletes every R2 object under the caller's uid. Does not delete the
 * Firebase account itself — the client does that separately. */
export function accountDeleteHandler(env: Env) {
  return async ({ request }: { request: Request }) => {
    const { uid } = await requireVerifiedUser(request, env);
    await deleteFolder(env.STORAGE, `${uid}/`);
    return new Response(null, { status: 204 });
  };
}
