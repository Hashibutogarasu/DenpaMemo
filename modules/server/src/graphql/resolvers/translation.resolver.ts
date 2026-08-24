import type { DataSource } from 'typeorm';
import { TranslationEntity, type TranslationEntityType } from '../../entities/translation.entity';

export async function resolveTranslations(dataSource: DataSource, map: string, locale: string) {
  return dataSource.getRepository(TranslationEntity).find({
    where: { entityType: map as TranslationEntityType, locale },
  });
}
