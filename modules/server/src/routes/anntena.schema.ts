import { z } from 'zod';

export const convertSideSchema = z.enum(['category', 'specific']);
export const convertFormatSchema = z.enum(['id', 'translated']);

export const convertQuerySchema = z
  .object({
    from: convertSideSchema,
    to: convertSideSchema,
    inputFormat: convertFormatSchema,
    outputFormat: convertFormatSchema,
    input: z.string().min(1),
  })
  .refine((query) => query.from !== query.to, {
    message: 'from and to must differ',
    path: ['to'],
  });
