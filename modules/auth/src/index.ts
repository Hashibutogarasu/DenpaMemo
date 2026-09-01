import { buildApp } from './app';
import type { Env } from './env';

export default {
  async fetch(request: Request, env: Env, ctx: ExecutionContext): Promise<Response> {
    return buildApp(env).handle(request);
  },
};
