import { AwsClient } from 'aws4fetch';

export interface R2S3Credentials {
  accountId: string;
  accessKeyId: string;
  secretAccessKey: string;
  bucketName: string;
  /**
   * Overrides the R2 S3-compatible endpoint. Used to point at a local
   * S3-compatible server (e.g. MinIO, via docker-compose) during
   * development instead of the real `r2.cloudflarestorage.com` endpoint.
   */
  endpoint?: string;
}

/**
 * R2's S3-compatible endpoint for the given account, used for presigning
 * (the native `R2Bucket` binding has no presign method).
 */
export function r2S3Endpoint(credentials: R2S3Credentials): string {
  const base = credentials.endpoint ?? `https://${credentials.accountId}.r2.cloudflarestorage.com`;
  return `${base}/${credentials.bucketName}`;
}

export function createR2S3Client(credentials: R2S3Credentials): AwsClient {
  return new AwsClient({
    accessKeyId: credentials.accessKeyId,
    secretAccessKey: credentials.secretAccessKey,
    service: 's3',
    region: 'auto',
  });
}
