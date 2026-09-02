import { createR2S3Client, r2S3Endpoint, type R2S3Credentials } from './client';

export interface CloudFileObject {
  key: string;
  size: number;
  uploaded: Date;
}

/** Lists every object under [prefix] in [bucket] via the native R2 binding. */
export async function listObjects(
  bucket: R2Bucket,
  prefix: string,
): Promise<CloudFileObject[]> {
  const objects: CloudFileObject[] = [];
  let cursor: string | undefined;
  do {
    const listing = await bucket.list({ prefix, cursor });
    for (const object of listing.objects) {
      objects.push({ key: object.key, size: object.size, uploaded: object.uploaded });
    }
    cursor = listing.truncated ? listing.cursor : undefined;
  } while (cursor);
  return objects;
}

/**
 * Lists every object under [prefix] via R2's S3-compatible ListObjectsV2
 * API, rather than the native `R2Bucket` binding [listObjects] uses.
 * [credentials] (and its `endpoint` override for local development, e.g.
 * MinIO) may point at a different backing store than the binding — an
 * object PUT via a presigned URL signed with [credentials] is only
 * guaranteed to be visible through that same S3-compatible API.
 */
export async function listObjectsS3(
  credentials: R2S3Credentials,
  prefix: string,
): Promise<CloudFileObject[]> {
  const client = createR2S3Client(credentials);
  const objects: CloudFileObject[] = [];
  let continuationToken: string | undefined;
  do {
    const url = new URL(r2S3Endpoint(credentials));
    url.searchParams.set('list-type', '2');
    url.searchParams.set('prefix', prefix);
    if (continuationToken) {
      url.searchParams.set('continuation-token', continuationToken);
    }
    const response = await client.fetch(url);
    if (!response.ok) {
      throw new Error(`S3 ListObjectsV2 failed: ${response.status} ${await response.text()}`);
    }
    const xml = await response.text();
    for (const match of xml.matchAll(/<Contents>([\s\S]*?)<\/Contents>/g)) {
      const block = match[1];
      const key = block.match(/<Key>([\s\S]*?)<\/Key>/)?.[1];
      const size = block.match(/<Size>([\s\S]*?)<\/Size>/)?.[1];
      const lastModified = block.match(/<LastModified>([\s\S]*?)<\/LastModified>/)?.[1];
      if (key !== undefined && size !== undefined && lastModified !== undefined) {
        objects.push({
          key: decodeXmlEntities(key),
          size: Number(size),
          uploaded: new Date(lastModified),
        });
      }
    }
    const isTruncated = xml.match(/<IsTruncated>([\s\S]*?)<\/IsTruncated>/)?.[1] === 'true';
    continuationToken = isTruncated
      ? xml.match(/<NextContinuationToken>([\s\S]*?)<\/NextContinuationToken>/)?.[1]
      : undefined;
  } while (continuationToken);
  return objects;
}

function decodeXmlEntities(value: string): string {
  return value
    .replace(/&amp;/g, '&')
    .replace(/&lt;/g, '<')
    .replace(/&gt;/g, '>')
    .replace(/&quot;/g, '"')
    .replace(/&apos;/g, "'");
}
