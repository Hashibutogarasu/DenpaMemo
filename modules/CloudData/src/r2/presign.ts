import { createR2S3Client, r2S3Endpoint, type R2S3Credentials } from './client';

const DEFAULT_EXPIRES_SECONDS = 300;

async function presign(
  credentials: R2S3Credentials,
  key: string,
  method: 'PUT' | 'GET',
  expiresInSeconds: number,
): Promise<string> {
  const client = createR2S3Client(credentials);
  const url = new URL(`${r2S3Endpoint(credentials)}/${key}`);
  const signed = await client.sign(
    new Request(url, { method }),
    { aws: { signQuery: true }, expiresIn: expiresInSeconds } as never,
  );
  return signed.url;
}

/** Signs a short-lived PUT URL clients can upload a single object to. */
export function presignPutUrl(
  credentials: R2S3Credentials,
  key: string,
  expiresInSeconds = DEFAULT_EXPIRES_SECONDS,
): Promise<string> {
  return presign(credentials, key, 'PUT', expiresInSeconds);
}

/** Signs a short-lived GET URL clients can download a single object from. */
export function presignGetUrl(
  credentials: R2S3Credentials,
  key: string,
  expiresInSeconds = DEFAULT_EXPIRES_SECONDS,
): Promise<string> {
  return presign(credentials, key, 'GET', expiresInSeconds);
}
