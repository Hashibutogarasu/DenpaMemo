import type { z } from 'zod';

export interface ValidationIssue {
  message: string;
  path: Array<string | number>;
}

/** The one `{ error, issues }` shape every route in `modules/server` returns for a 4xx. */
export function validationErrorResponse(issues: ValidationIssue[]) {
  return { error: 'validation_error', issues };
}

/** Wraps a failed `zodSchema.safeParse(...)`'s issues in [validationErrorResponse]. */
export function zodErrorResponse(error: z.ZodError) {
  return validationErrorResponse(error.issues);
}

/** A single-issue [validationErrorResponse], for a lookup that found nothing. */
export function notFoundResponse(message: string, path: Array<string | number> = ['input']) {
  return validationErrorResponse([{ message, path }]);
}
