import { z } from 'zod';

/** Query params for `GET /physiques/evasion-rate-table/search`. */
export const searchEvasionRateTableQuerySchema = z.object({
  evasionRate: z.coerce.number().int(),
  hp: z.coerce.number().int(),
  anntenaCategory: z.string().min(1).optional(),
  category: z.string().min(1).optional(),
});
