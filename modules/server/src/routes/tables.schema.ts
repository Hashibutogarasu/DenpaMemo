import { z } from 'zod';

/** `type` is validated against the DB + entity-mapping registry at request time, not here. */
export const tableTypeSchema = z.string().min(1);

/** A cell left blank is `null`, not coerced to `0` — a deliberate, storable value. */
export const tableValuesSchema = z.array(z.number().nullable()).min(1);

export const tableRecordInputSchema = z.object({
  type: tableTypeSchema,
  level: z.string().min(1),
  anntenaCategory: z.string().min(1),
  lineOffset: z.number().int().nonnegative().optional(),
  values: tableValuesSchema,
});

export const postTablesBodySchema = z.union([
  tableRecordInputSchema,
  z.array(tableRecordInputSchema).min(1),
]);

export const getTablesQuerySchema = z.object({
  type: tableTypeSchema,
  level: z.string().min(1).optional(),
  anntenaCategory: z.string().min(1).optional(),
  category: z.string().min(1).optional(),
});

/** Shape of a single row's update payload within `PUT /tables`. */
export const putTablesRowSchema = z.object({
  values: tableValuesSchema,
});

export const putTablesBodySchema = z.object({
  type: tableTypeSchema,
  lineOffset: z.number().int().nonnegative(),
  level: z.string().min(1),
  anntenaCategory: z.string().min(1),
  records: z.array(putTablesRowSchema).min(1),
});

export function putTablesBodySchemaWithBounds(currentRowCount: number) {
  return putTablesBodySchema.refine(
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

export const deleteTablesQuerySchema = z
  .object({
    type: tableTypeSchema,
    level: z.string().min(1).optional(),
    anntenaCategory: z.string().min(1).optional(),
    lineOffsets: lineOffsetsQuerySchema.optional(),
  })
  .refine((query) => query.level !== undefined || query.anntenaCategory !== undefined, {
    message: 'At least one of level or anntenaCategory must be provided',
  })
  .refine(
    (query) =>
      query.lineOffsets === undefined || (query.level !== undefined && query.anntenaCategory !== undefined),
    {
      message: 'lineOffsets requires level and anntenaCategory',
      path: ['lineOffsets'],
    },
  );

export const searchTablesQuerySchema = z.object({
  type: tableTypeSchema.optional().default('evasionRate'),
  against: tableTypeSchema.optional().default('hp'),
  evasionRate: z.coerce.number().int(),
  hp: z.coerce.number().int(),
  level: z.string().min(1).optional(),
  anntenaCategory: z.string().min(1).optional(),
  category: z.string().min(1).optional(),
  antenna: z.string().min(1).optional(),
});

export const legendGridQuerySchema = z
  .object({
    level: z.string().min(1),
    anntenaCategory: z.string().min(1).optional(),
    antenna: z.string().min(1).optional(),
    matchColumnIndex: z.coerce.number().int().nonnegative(),
    matchLineOffset: z.coerce.number().int().nonnegative(),
    matchEvasionRate: z.coerce.number().int(),
  })
  .refine((query) => query.anntenaCategory !== undefined || query.antenna !== undefined, {
    message: 'One of anntenaCategory or antenna must be provided',
  });
