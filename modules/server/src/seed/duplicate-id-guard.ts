export class DuplicateMasterDataIdError extends Error {
  constructor(entityType: string, legacyId: string, source: string) {
    super(`Duplicate ${entityType} id "${legacyId}" found while loading ${source}`);
    this.name = 'DuplicateMasterDataIdError';
  }
}

/**
 * Tracks `legacyId`s seen so far per master-data entity type, throwing
 * `DuplicateMasterDataIdError` before any DB write if the same id turns
 * up twice. The DB's `unique(legacyId)` index (see `BaseEntity`) is the
 * second line of defense, in case this guard is ever bypassed.
 */
export class DuplicateIdGuard {
  private readonly seenByEntityType = new Map<string, Set<string>>();

  check(entityType: string, legacyId: string, source: string): void {
    let seen = this.seenByEntityType.get(entityType);
    if (!seen) {
      seen = new Set();
      this.seenByEntityType.set(entityType, seen);
    }
    if (seen.has(legacyId)) {
      throw new DuplicateMasterDataIdError(entityType, legacyId, source);
    }
    seen.add(legacyId);
  }
}
