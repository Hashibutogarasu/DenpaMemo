import { InvalidIdTokenError, verifyIdToken, type VerifiedIdToken } from '@Hashibutogarasu/denpa-memo-cloud-data';
import type { Env } from './env';
import { UnauthorizedError } from './http-errors';

/**
 * Extracts the Bearer token from [request] and verifies it via
 * `@Hashibutogarasu/denpa-memo-cloud-data`, so every route resolves the
 * caller's uid through this single shared path.
 */
export async function requireVerifiedUser(
  request: Request,
  env: Env,
): Promise<VerifiedIdToken> {
  const header = request.headers.get('Authorization');
  if (!header?.startsWith('Bearer ')) {
    throw new UnauthorizedError();
  }
  const token = header.slice('Bearer '.length);
  try {
    return await verifyIdToken(token, env.FIREBASE_PROJECT_ID);
  } catch (error) {
    if (error instanceof InvalidIdTokenError) {
      throw new UnauthorizedError(error.message);
    }
    throw error;
  }
}
