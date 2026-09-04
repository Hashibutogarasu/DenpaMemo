import type { AnntenaEntity } from '../../entities/anntena.entity';
import type { MinorCategoryEntity } from '../../entities/minor-category.entity';
import type { PhysiqueAntennaCategoryAntennaEntity } from '../../entities/physique-antenna-category-antenna.entity';
import type { TranslationEntity } from '../../entities/translation.entity';

export interface MinorCategoryRepository {
  findOneBy(where: Partial<Pick<MinorCategoryEntity, 'id'>>): Promise<MinorCategoryEntity | null>;
}

export interface AnntenaRepository {
  findOneBy(where: Partial<Pick<AnntenaEntity, 'id'>>): Promise<AnntenaEntity | null>;
}

export interface TranslationRepository {
  findOneBy(
    where: Partial<Pick<TranslationEntity, 'entityType' | 'entityLegacyId' | 'locale' | 'value'>>,
  ): Promise<TranslationEntity | null>;
}

export interface AntennaCategoryLinkRepository {
  find(options: {
    where: Partial<Pick<PhysiqueAntennaCategoryAntennaEntity, 'minorCategoryId'>>;
  }): Promise<PhysiqueAntennaCategoryAntennaEntity[]>;
  findOneBy(
    where: Partial<Pick<PhysiqueAntennaCategoryAntennaEntity, 'anntenaId'>>,
  ): Promise<PhysiqueAntennaCategoryAntennaEntity | null>;
}

/**
 * Single point of access for resolving between physique antenna minor
 * categories and concrete antennas — the data `GET /anntena/convert`
 * (see `src/routes/anntena.route.ts`) converts between. Depends only on
 * narrow repository interfaces, never a `DataSource` directly, so a
 * black-box test can supply plain in-memory fakes instead of a real
 * database.
 */
export class AntennaCategoryLinkDataSource {
  constructor(
    private readonly minorCategoryRepo: MinorCategoryRepository,
    private readonly anntenaRepo: AnntenaRepository,
    private readonly translationRepo: TranslationRepository,
    private readonly linkRepo: AntennaCategoryLinkRepository,
  ) {}

  findMinorCategoryById(id: string): Promise<MinorCategoryEntity | null> {
    return this.minorCategoryRepo.findOneBy({ id });
  }

  findAntennaById(id: string): Promise<AnntenaEntity | null> {
    return this.anntenaRepo.findOneBy({ id });
  }

  /** Resolves a translated antenna display name back to its `id`. */
  async findAntennaIdByTranslatedName(value: string, locale: string): Promise<string | undefined> {
    const translation = await this.translationRepo.findOneBy({ entityType: 'antenna', locale, value });
    return translation?.entityLegacyId;
  }

  /** Resolves an antenna's `id` to its translated display name. */
  async findAntennaTranslatedName(id: string, locale: string): Promise<string | undefined> {
    const translation = await this.translationRepo.findOneBy({
      entityType: 'antenna',
      entityLegacyId: id,
      locale,
    });
    return translation?.value;
  }

  findLinksForMinorCategory(minorCategoryId: string): Promise<PhysiqueAntennaCategoryAntennaEntity[]> {
    return this.linkRepo.find({ where: { minorCategoryId } });
  }

  findLinkForAntenna(anntenaId: string): Promise<PhysiqueAntennaCategoryAntennaEntity | null> {
    return this.linkRepo.findOneBy({ anntenaId });
  }
}
