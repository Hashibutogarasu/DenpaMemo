import type { R2S3Credentials } from '@Hashibutogarasu/denpa-memo-cloud-data';
import type { Env } from './env';

const BUCKET_NAME = 'denpa-memo-storage';

export function r2CredentialsFromEnv(env: Env): R2S3Credentials {
  return {
    accountId: env.R2_ACCOUNT_ID,
    accessKeyId: env.R2_ACCESS_KEY_ID,
    secretAccessKey: env.R2_SECRET_ACCESS_KEY,
    bucketName: BUCKET_NAME,
    endpoint: env.R2_S3_ENDPOINT,
  };
}
