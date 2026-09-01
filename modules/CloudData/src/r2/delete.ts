import { listObjects } from './list';

const BATCH_DELETE_LIMIT = 1000;

export async function deleteObject(bucket: R2Bucket, key: string): Promise<void> {
  await bucket.delete(key);
}

/** Deletes every object under [prefix] in [bucket]. */
export async function deleteFolder(bucket: R2Bucket, prefix: string): Promise<void> {
  const objects = await listObjects(bucket, prefix);
  for (let i = 0; i < objects.length; i += BATCH_DELETE_LIMIT) {
    const batch = objects.slice(i, i + BATCH_DELETE_LIMIT).map((object) => object.key);
    await bucket.delete(batch);
  }
}
