import { Elysia } from 'elysia';
import type { DataSource } from 'typeorm';
import type { z } from 'zod';
import { findEvasionRateMatches } from '../domain/physique/evasion-rate-search';
import { PhysiqueAntennaCategoryEntity } from '../entities/physique-antenna-category.entity';
import { PhysiqueEvasionRateTableEntity } from '../entities/physique-evasion-rate-table.entity';
import { PhysiqueTableEntity } from '../entities/physique-table.entity';
import { searchEvasionRateTableQuerySchema } from './evasion-rate-table.schema';

function zodErrorResponse(error: z.ZodError) {
  return { error: 'validation_error', issues: error.issues };
}

/**
 * Search-only REST for the evasion-rate table: cross-references
 * `PhysiqueEvasionRateTableEntity` against `PhysiqueTableEntity`'s `HP`
 * rows — see `src/domain/physique/evasion-rate-search.ts`. There is no
 * write endpoint here; rows must be inserted directly against the table.
 */
export function evasionRateTableRoutes(dataSource: DataSource) {
  const evasionRateRepo = dataSource.getRepository(PhysiqueEvasionRateTableEntity);
  const physiqueTableRepo = dataSource.getRepository(PhysiqueTableEntity);
  const categoryRepo = dataSource.getRepository(PhysiqueAntennaCategoryEntity);

  return new Elysia().group('/physiques/evasion-rate-table', (app) =>
    app.get('/search', async ({ query, set }) => {
      const parsed = searchEvasionRateTableQuerySchema.safeParse(query);
      if (!parsed.success) {
        set.status = 400;
        return zodErrorResponse(parsed.error);
      }
      const { evasionRate, hp, anntenaCategory, category } = parsed.data;

      let anntenaCategoryFilter: string[] | undefined;
      if (category !== undefined) {
        const rows = await categoryRepo.find({ where: { category } });
        anntenaCategoryFilter = rows.map((row) => row.anntenaCategory);
        if (anntenaCategoryFilter.length === 0) {
          return [];
        }
      }

      const evasionWhere: Partial<Pick<PhysiqueEvasionRateTableEntity, 'anntenaCategory'>> = {};
      const hpWhere: Partial<Pick<PhysiqueTableEntity, 'statusCategory' | 'anntenaCategory'>> = {
        statusCategory: 'HP',
      };
      if (anntenaCategory !== undefined) {
        evasionWhere.anntenaCategory = anntenaCategory;
        hpWhere.anntenaCategory = anntenaCategory;
      }

      const [evasionRows, hpRows] =
        anntenaCategoryFilter !== undefined
          ? await Promise.all([
              evasionRateRepo
                .createQueryBuilder('row')
                .where('row.anntenaCategory IN (:...anntenaCategoryFilter)', { anntenaCategoryFilter })
                .getMany(),
              physiqueTableRepo
                .createQueryBuilder('row')
                .where('row.statusCategory = :statusCategory', { statusCategory: 'HP' })
                .andWhere('row.anntenaCategory IN (:...anntenaCategoryFilter)', { anntenaCategoryFilter })
                .getMany(),
            ])
          : await Promise.all([
              evasionRateRepo.find({ where: evasionWhere }),
              physiqueTableRepo.find({ where: hpWhere }),
            ]);

      return findEvasionRateMatches(evasionRows, hpRows, evasionRate, hp);
    }),
  );
}
