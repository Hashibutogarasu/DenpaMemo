import { readFile } from 'node:fs/promises';
import path from 'node:path';
import type { DataSource } from 'typeorm';
import { TableDefinitionEntity } from '../../entities/table-definition.entity';
import type { DuplicateIdGuard } from '../duplicate-id-guard';

const FILE_NAME = 'table_definitions.json';

interface TableDefinitionJson {
  type: string;
  columnCount: number;
  translationKey: string;
}

export async function loadTableDefinitions(
  dataSource: DataSource,
  dataDir: string,
  guard: DuplicateIdGuard,
): Promise<void> {
  const filePath = path.join(dataDir, FILE_NAME);
  const rows = JSON.parse(await readFile(filePath, 'utf-8')) as TableDefinitionJson[];

  const entities: TableDefinitionEntity[] = [];
  for (const row of rows) {
    guard.check('table_definition', row.type, FILE_NAME);
    const entity = new TableDefinitionEntity();
    entity.type = row.type;
    entity.columnCount = row.columnCount;
    entity.translationKey = row.translationKey;
    entities.push(entity);
  }

  await dataSource.getRepository(TableDefinitionEntity).save(entities);
}
