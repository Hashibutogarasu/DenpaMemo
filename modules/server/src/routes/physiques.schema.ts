import { z } from 'zod';

/** Values for one physique table row. */
export const physiqueTableValuesSchema = z.array(z.number()).min(1);

/** Body shape for a single record accepted by `POST /physiques`. */
export const physiqueRecordInputSchema = z.object({
  level: z.string().min(1),
  anntenaCategory: z.string().min(1),
  lineOffset: z.number().int().nonnegative().optional(),
  values: physiqueTableValuesSchema,
});

export const postPhysiquesBodySchema = z.union([
  physiqueRecordInputSchema,
  z.array(physiqueRecordInputSchema).min(1),
]);

export const getPhysiquesQuerySchema = z.object({
  level: z.string().min(1).optional(),
  anntenaCategory: z.string().min(1).optional(),
  category: z.string().min(1).optional(),
});

/** Shape of a single row's update payload within `PUT /physiques`. */
export const putPhysiquesRowSchema = z.object({
  values: physiqueTableValuesSchema,
});

export const putPhysiquesBodySchema = z.object({
  lineOffset: z.number().int().nonnegative(),
  level: z.string().min(1),
  anntenaCategory: z.string().min(1),
  records: z.array(putPhysiquesRowSchema).min(1),
});

export function putPhysiquesBodySchemaWithBounds(currentRowCount: number) {
  return putPhysiquesBodySchema.refine(
    (data) => data.lineOffset + data.records.length <= currentRowCount,
    {
      message: `lineOffset and record count exceed the table's current row count (${currentRowCount})`,
      path: ['lineOffset'],
    },
  );
}

/** Comma-separated `lineOffset` list, e.g. `"0,2,4"`, for row-targeted deletes. */
export const lineOffsetsQuerySchema = z
  .string()
  .min(1)
  .transform((value) => value.split(',').map((part) => Number(part.trim())))
  .refine((values) => values.every((value) => Number.isInteger(value) && value >= 0), {
    message: 'lineOffsets must be a comma-separated list of non-negative integers',
  });

export const deletePhysiquesQuerySchema = z
  .object({
    level: z.string().min(1).optional(),
    anntenaCategory: z.string().min(1).optional(),
    lineOffsets: lineOffsetsQuerySchema.optional(),
  })
  .refine((query) => query.level !== undefined || query.anntenaCategory !== undefined, {
    message: 'At least one of level or anntenaCategory must be provided',
  })
  .refine(
    (query) => query.lineOffsets === undefined || (query.level !== undefined && query.anntenaCategory !== undefined),
    {
      message: 'lineOffsets requires both level and anntenaCategory',
      path: ['lineOffsets'],
    },
  );
