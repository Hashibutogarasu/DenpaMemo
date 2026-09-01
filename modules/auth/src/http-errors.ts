export type ErrorCode = 'unauthorized' | 'forbidden' | 'not_found' | 'bad_request';

export class HttpError extends Error {
  constructor(
    public readonly status: number,
    public readonly code: ErrorCode,
    message: string,
  ) {
    super(message);
    this.name = 'HttpError';
  }
}

export class UnauthorizedError extends HttpError {
  constructor(message = 'missing or invalid Authorization header') {
    super(401, 'unauthorized', message);
  }
}

export class ForbiddenError extends HttpError {
  constructor(message = 'not allowed to access this resource') {
    super(403, 'forbidden', message);
  }
}

export class NotFoundError extends HttpError {
  constructor(message = 'resource not found') {
    super(404, 'not_found', message);
  }
}

export class BadRequestError extends HttpError {
  constructor(message: string) {
    super(400, 'bad_request', message);
  }
}
