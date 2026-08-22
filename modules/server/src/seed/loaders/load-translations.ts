import { readFile } from 'node:fs/promises';
import path from 'node:path';
import type { DataSource } from 'typeorm';
import { TranslationEntity, type TranslationEntityType } from '../../entities/translation.entity';

const LOCALE = 'ja';

type TranslationsJson = Partial<Record<TranslationEntityType, Record<string, string>>>;

export async function loadTranslations(dataSource: DataSource, dataDir: string): Promise<void> {
  const filePath = path.join(dataDir, 'translations', `${LOCALE}.json`);
  const json = JSON.parse(await readFile(filePath, 'utf-8')) as TranslationsJson;

  const entities: TranslationEntity[] = [];
  for (const [entityType, values] of Object.entries(json) as Array<[TranslationEntityType, Record<string, string>]>) {
    for (const [entityLegacyId, value] of Object.entries(values)) {
      const entity = new TranslationEntity();
      entity.entityType = entityType;
      entity.entityLegacyId = entityLegacyId;
      entity.locale = LOCALE;
      entity.value = value;
      entities.push(entity);
    }
  }

  await dataSource.getRepository(TranslationEntity).save(entities);
}
