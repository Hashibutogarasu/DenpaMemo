import { deleteFolder } from '@Hashibutogarasu/denpa-memo-cloud-data';
import { requireVerifiedUser } from '../auth-context';
import { BadRequestError } from '../http-errors';
import type { Env } from '../env';

export function dmFileDeleteHandler(env: Env) {
  return async ({ request, query }: { request: Request; query: Record<string, string | undefined> }) => {
    const { uid } = await requireVerifiedUser(request, env);
    const fileId = query.fileId;
    if (typeof fileId !== 'string' || fileId.length === 0) {
      throw new BadRequestError('fileId query parameter is required');
    }
    await deleteFolder(env.STORAGE, `${uid}/${fileId}/`);
    return new Response(null, { status: 204 });
  };
}
