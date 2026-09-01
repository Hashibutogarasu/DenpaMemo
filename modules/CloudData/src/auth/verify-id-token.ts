import { createRemoteJWKSet, jwtVerify } from 'jose';

const FIREBASE_JWKS_URL =
  'https://www.googleapis.com/service_accounts/v1/jwk/securetoken@system.gserviceaccount.com';

let jwks: ReturnType<typeof createRemoteJWKSet> | undefined;

function getJwks() {
  jwks ??= createRemoteJWKSet(new URL(FIREBASE_JWKS_URL));
  return jwks;
}

export class InvalidIdTokenError extends Error {
  constructor(cause: unknown) {
    super('Invalid Firebase ID token', { cause });
    this.name = 'InvalidIdTokenError';
  }
}

export interface VerifiedIdToken {
  uid: string;
  email?: string;
}

/**
 * Verifies a Firebase Authentication ID token against Google's public
 * JWKS for the `securetoken` service account, without depending on the
 * (Workers-incompatible) firebase-admin SDK.
 */
export async function verifyIdToken(
  token: string,
  projectId: string,
): Promise<VerifiedIdToken> {
  try {
    const { payload } = await jwtVerify(token, getJwks(), {
      issuer: `https://securetoken.google.com/${projectId}`,
      audience: projectId,
    });
    if (typeof payload.sub !== 'string') {
      throw new Error('missing sub claim');
    }
    return {
      uid: payload.sub,
      email: typeof payload.email === 'string' ? payload.email : undefined,
    };
  } catch (error) {
    throw new InvalidIdTokenError(error);
  }
}
