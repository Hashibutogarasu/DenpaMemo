import { readFile } from 'node:fs/promises';
import path from 'node:path';
import type { DataSource } from 'typeorm';
import { CorrectionEntity } from '../../entities/correction.entity';
import type { DuplicateIdGuard } from '../duplicate-id-guard';

interface CorrectionJson {
  id: string;
  hpBonus?: number;
  apBonus?: number;
  attackBonus?: number;
  defenseBonus?: number;
  speedBonus?: number;
  evasionRateBonus?: number;
  abnormalityResistanceBonuses?: Record<string, number>;
}

export async function loadCorrections(
  dataSource: DataSource,
  dataDir: string,
  guard: DuplicateIdGuard,
): Promise<void> {
  const filePath = path.join(dataDir, 'corrections.json');
  const rows = JSON.parse(await readFile(filePath, 'utf-8')) as CorrectionJson[];

  const entities = rows.map((row) => {
    guard.check('correction', row.id, 'corrections.json');
    const entity = new CorrectionEntity();
    entity.id = row.id;
    entity.hpBonus = row.hpBonus ?? 0;
    entity.apBonus = row.apBonus ?? 0;
    entity.attackBonus = row.attackBonus ?? 0;
    entity.defenseBonus = row.defenseBonus ?? 0;
    entity.speedBonus = row.speedBonus ?? 0;
    entity.evasionRateBonus = row.evasionRateBonus ?? 0;
    entity.abnormalityResistanceBonuses = row.abnormalityResistanceBonuses ?? {};
    return entity;
  });

  await dataSource.getRepository(CorrectionEntity).save(entities);
}
