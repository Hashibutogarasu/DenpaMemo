import { Elysia } from 'elysia';
import type { DataSource } from 'typeorm';
import type { z } from 'zod';
import { PhysiqueAntennaCategoryEntity } from '../entities/physique-antenna-category.entity';
import { PhysiqueTableEntity } from '../entities/physique-table.entity';
import {
  deletePhysiquesQuerySchema,
  getPhysiquesQuerySchema,
  postPhysiquesBodySchema,
  putPhysiquesBodySchema,
  putPhysiquesBodySchemaWithBounds,
} from './physiques.schema';

function zodErrorResponse(error: z.ZodError) {
  return { error: 'validation_error', issues: error.issues };
}

/**
 * Deletes the rows at `lineOffsets` within one `level`/`anntenaCategory`
 * table, then re-sequences the remaining rows' `lineOffset`s back to a
 * contiguous `0..n-1` range so `PUT /physiques` (which indexes into the
 * table by array position, see below) and the row-number column Flutter
 * displays stay gap-free after a delete.
 */
async function deletePhysiqueTableRows(
  dataSource: DataSource,
  level: string,
  anntenaCategory: string,
  lineOffsets: number[],
): Promise<void> {
  const offsetsToDelete = new Set(lineOffsets);
  await dataSource.transaction(async (manager) => {
    const txRepo = manager.getRepository(PhysiqueTableEntity);
    const rows = await txRepo.find({
      where: { level, anntenaCategory },
      order: { lineOffset: 'ASC' },
    });

    const toDelete = rows.filter((row) => offsetsToDelete.has(row.lineOffset));
    if (toDelete.length > 0) {
      await txRepo.remove(toDelete);
    }

    const remaining = rows.filter((row) => !offsetsToDelete.has(row.lineOffset));
    for (let i = 0; i < remaining.length; i += 1) {
      if (remaining[i].lineOffset !== i) {
        remaining[i].lineOffset = i;
        await txRepo.save(remaining[i]);
      }
    }
  });
}

/**
 * REST CRUD for physique table rows. Unlike the rest of
 * `modules/server`, these rows are written entirely through this route
 * (no JSON seed) — see `PhysiqueTableEntity` and the plan this was built
 * from for the reasoning behind the record shape.
 */
export function physiquesRoutes(dataSource: DataSource) {
  const repo = dataSource.getRepository(PhysiqueTableEntity);
  const categoryRepo = dataSource.getRepository(PhysiqueAntennaCategoryEntity);

  return new Elysia().group('/physiques', (app) =>
    app
      .post('/', async ({ body, set }) => {
        const parsed = postPhysiquesBodySchema.safeParse(body);
        if (!parsed.success) {
          set.status = 400;
          return zodErrorResponse(parsed.error);
        }
        const records = Array.isArray(parsed.data) ? parsed.data : [parsed.data];

        const saved: PhysiqueTableEntity[] = [];
        for (const record of records) {
          let lineOffset = record.lineOffset;
          if (lineOffset === undefined) {
            lineOffset = await repo.count({ where: { level: record.level, anntenaCategory: record.anntenaCategory } });
          }
          const entity = repo.create({
            level: record.level,
            anntenaCategory: record.anntenaCategory,
            lineOffset,
            values: record.values,
          });
          saved.push(await repo.save(entity));
        }

        set.status = 201;
        return saved;
      })
      .get('/', async ({ query, set }) => {
        const parsed = getPhysiquesQuerySchema.safeParse(query);
        if (!parsed.success) {
          set.status = 400;
          return zodErrorResponse(parsed.error);
        }
        const { level, anntenaCategory, category } = parsed.data;

        let anntenaCategoryFilter: string[] | undefined;
        if (category !== undefined) {
          const rows = await categoryRepo.find({ where: { category } });
          anntenaCategoryFilter = rows.map((row) => row.anntenaCategory);
        }

        if (anntenaCategoryFilter !== undefined) {
          if (anntenaCategoryFilter.length === 0) {
            return [];
          }
          const qb = repo
            .createQueryBuilder('row')
            .where('row.anntenaCategory IN (:...anntenaCategoryFilter)', { anntenaCategoryFilter })
            .orderBy('row.lineOffset', 'ASC');
          if (level !== undefined) {
            qb.andWhere('row.level = :level', { level });
          }
          if (anntenaCategory !== undefined) {
            qb.andWhere('row.anntenaCategory = :anntenaCategory', { anntenaCategory });
          }
          return qb.getMany();
        }

        const where: Partial<Pick<PhysiqueTableEntity, 'level' | 'anntenaCategory'>> = {};
        if (level !== undefined) where.level = level;
        if (anntenaCategory !== undefined) where.anntenaCategory = anntenaCategory;

        return repo.find({ where, order: { lineOffset: 'ASC' } });
      })
      .put('/', async ({ body, set }) => {
        const shapeParsed = putPhysiquesBodySchema.safeParse(body);
        if (!shapeParsed.success) {
          set.status = 400;
          return zodErrorResponse(shapeParsed.error);
        }
        const { lineOffset, level, anntenaCategory, records } = shapeParsed.data;

        const currentRowCount = await repo.count({ where: { level, anntenaCategory } });
        const boundedParsed = putPhysiquesBodySchemaWithBounds(currentRowCount).safeParse(body);
        if (!boundedParsed.success) {
          set.status = 400;
          return zodErrorResponse(boundedParsed.error);
        }

        const targetRows = await repo.find({
          where: { level, anntenaCategory },
          order: { lineOffset: 'ASC' },
        });

        const updated: PhysiqueTableEntity[] = [];
        for (let i = 0; i < records.length; i += 1) {
          const target = targetRows[lineOffset + i];
          target.values = records[i].values;
          updated.push(await repo.save(target));
        }

        return updated;
      })
      .delete('/', async ({ query, set }) => {
        const parsed = deletePhysiquesQuerySchema.safeParse(query);
        if (!parsed.success) {
          set.status = 400;
          return zodErrorResponse(parsed.error);
        }
        const { level, anntenaCategory, lineOffsets } = parsed.data;

        if (lineOffsets !== undefined) {
          // level and anntenaCategory are both required alongside lineOffsets
          // (enforced by deletePhysiquesQuerySchema's refine).
          await deletePhysiqueTableRows(dataSource, level!, anntenaCategory!, lineOffsets);
          set.status = 204;
          return null;
        }

        const where: Partial<Pick<PhysiqueTableEntity, 'level' | 'anntenaCategory'>> = {};
        if (level !== undefined) where.level = level;
        if (anntenaCategory !== undefined) where.anntenaCategory = anntenaCategory;

        await repo.delete(where);
        set.status = 204;
        return null;
      }),
  );
}
