import 'reflect-metadata';
import { Elysia } from 'elysia';
import { node } from '@elysiajs/node';
import { createYoga } from 'graphql-yoga';
import { env } from './config/env';
import { AppDataSource } from './config/data-source';
import { runSeedIfNeeded } from './seed/run-seed';
import { buildSchema } from './graphql/schema';
import { physiquesRoutes } from './routes/physiques.route';

async function main() {
  await AppDataSource.initialize();
  await AppDataSource.runMigrations();
  await runSeedIfNeeded(AppDataSource);

  const yoga = createYoga({ schema: buildSchema(AppDataSource), graphqlEndpoint: '/' });

  const app = new Elysia({ adapter: node() })
    .get('/health', () => ({ status: 'ok' }))
    .use(physiquesRoutes(AppDataSource))
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
