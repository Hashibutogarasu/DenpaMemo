import { mkdtemp, mkdir, rm, writeFile } from 'node:fs/promises';
import { tmpdir } from 'node:os';
import path from 'node:path';
import { afterEach, beforeEach, describe, expect, test } from 'vitest';
import { DuplicateFileNameError, listJsonFilesRecursively } from '../../src/seed/list-json-files';

let dir: string;

beforeEach(async () => {
  dir = await mkdtemp(path.join(tmpdir(), 'list-json-files-'));
});

afterEach(async () => {
  await rm(dir, { recursive: true, force: true });
});

describe('listJsonFilesRecursively', () => {
  test('lists every .json file across nested subdirectories', async () => {
    await mkdir(path.join(dir, 'a'), { recursive: true });
    await mkdir(path.join(dir, 'b'), { recursive: true });
    await writeFile(path.join(dir, 'a', 'one.json'), '[]');
    await writeFile(path.join(dir, 'b', 'two.json'), '[]');
    await writeFile(path.join(dir, 'b', 'ignored.txt'), '');

    const files = await listJsonFilesRecursively(dir);

    expect(files.sort()).toEqual([path.join(dir, 'a', 'one.json'), path.join(dir, 'b', 'two.json')].sort());
  });

  test('throws DuplicateFileNameError when the same file name appears under two subdirectories', async () => {
    await mkdir(path.join(dir, 'support'), { recursive: true });
    await mkdir(path.join(dir, 'other'), { recursive: true });
    await writeFile(path.join(dir, 'support', 'speedDown.json'), '[]');
    await writeFile(path.join(dir, 'other', 'speedDown.json'), '[]');

    await expect(listJsonFilesRecursively(dir)).rejects.toThrow(DuplicateFileNameError);
  });
});
