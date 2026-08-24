import { readdir } from 'node:fs/promises';
import path from 'node:path';

export class DuplicateFileNameError extends Error {
  constructor(fileName: string, first: string, second: string) {
    super(`Duplicate file name "${fileName}" found at both "${first}" and "${second}"`);
    this.name = 'DuplicateFileNameError';
  }
}

/**
 * Recursively lists every `.json` file under `dir`, throwing
 * `DuplicateFileNameError` before any caller can act on the result if the
 * same base file name appears more than once (e.g. the same antenna
 * defined under two different category subdirectories). Callers that run
 * this before opening a DB transaction never write partial data for a
 * conflicting master-data set.
 */
export async function listJsonFilesRecursively(dir: string): Promise<string[]> {
  const files = await collectJsonFiles(dir);
  assertNoDuplicateFileNames(files);
  return files;
}

async function collectJsonFiles(dir: string): Promise<string[]> {
  const entries = await readdir(dir, { withFileTypes: true });
  const files: string[] = [];
  for (const entry of entries) {
    const entryPath = path.join(dir, entry.name);
    if (entry.isDirectory()) {
      files.push(...(await collectJsonFiles(entryPath)));
    } else if (entry.name.endsWith('.json')) {
      files.push(entryPath);
    }
  }
  return files;
}

function assertNoDuplicateFileNames(files: string[]): void {
  const seenByBaseName = new Map<string, string>();
  for (const file of files) {
    const baseName = path.basename(file);
    const existing = seenByBaseName.get(baseName);
    if (existing) {
      throw new DuplicateFileNameError(baseName, existing, file);
    }
    seenByBaseName.set(baseName, file);
  }
}
