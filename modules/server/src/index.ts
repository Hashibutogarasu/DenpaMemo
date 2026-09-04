import 'reflect-metadata';
import { Elysia, NotFoundError, ValidationError } from 'elysia';
import { node } from '@elysiajs/node';
import { createYoga } from 'graphql-yoga';
import { env } from './config/env';
import { AppDataSource } from './config/data-source';
import { runSeedIfNeeded } from './seed/run-seed';
import { buildSchema } from './graphql/schema';
import { anntenaRoutes } from './routes/anntena.route';
import { tablesRoutes } from './routes/tables.route';
import { notFoundResponse } from './http/validation-response';

async function main() {
  await AppDataSource.initialize();
  await AppDataSource.runMigrations();
  await runSeedIfNeeded(AppDataSource);

  const yoga = createYoga({ schema: buildSchema(AppDataSource), graphqlEndpoint: '/' });

  const app = new Elysia({ adapter: node() })
    .onError(({ error, set }) => {
      if (error instanceof NotFoundError) {
        set.status = error.status;
        return notFoundResponse(error.message);
      }
      if (error instanceof ValidationError) return;
      console.error('Unhandled request error', error);
      set.status = 500;
      return { error: error instanceof Error ? error.message : 'internal_error' };
    })
    .get('/health', () => ({ status: 'ok' }))
    .use(tablesRoutes(AppDataSource))
    .use(anntenaRoutes(AppDataSource))
    .mount('/graphql', async (request: Request) => {
      const yogaResponse = await yoga.fetch(request);
      const body = await yogaResponse.arrayBuffer();
      return new Response(body, {
        status: yogaResponse.status,
        headers: yogaResponse.headers,
      });
    })
    .listen(env.PORT);

  console.log(`Server listening on http://localhost:${env.PORT}/graphql`);
  return app;
}

main().catch((error) => {
  console.error('Failed to start server', error);
  process.exit(1);
});
