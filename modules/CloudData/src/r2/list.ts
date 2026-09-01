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
