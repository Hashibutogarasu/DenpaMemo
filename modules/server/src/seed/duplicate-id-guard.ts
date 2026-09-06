export class DuplicateMasterDataIdError extends Error {
  constructor(entityType: string, id: string, source: string) {
    super(`Duplicate ${entityType} id "${id}" found while loading ${source}`);
    this.name = 'DuplicateMasterDataIdError';
  }
}

/**
 * Tracks `id`s seen so far per master-data entity type, throwing
 * `DuplicateMasterDataIdError` before any DB write if the same id turns
 * up twice. The DB's primary key (see `BaseEntity`) is the second line
 * of defense, in case this guard is ever bypassed.
 */
export class DuplicateIdGuard {
  private readonly seenByEntityType = new Map<string, Set<string>>();

  check(entityType: string, id: string, source: string): void {
    let seen = this.seenByEntityType.get(entityType);
    if (!seen) {
      seen = new Set();
      this.seenByEntityType.set(entityType, seen);
    }
    if (seen.has(id)) {
      throw new DuplicateMasterDataIdError(entityType, id, source);
    }
    seen.add(id);
  }
}
