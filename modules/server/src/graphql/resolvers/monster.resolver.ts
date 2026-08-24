import type { DataSource } from 'typeorm';
import { MonsterEntity } from '../../entities/monster.entity';

/** Isolated from `resolveMasterData`: monsters are not master data. */
export async function resolveMonsters(dataSource: DataSource) {
  return dataSource.getRepository(MonsterEntity).find();
}
