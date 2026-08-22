import 'reflect-metadata';
import { Elysia } from 'elysia';
import { node } from '@elysiajs/node';
import { createYoga } from 'graphql-yoga';
import { env } from './config/env';
import { AppDataSource } from './config/data-source';
import { runSeedIfNeeded } from './seed/run-seed';
import { buildSchema } from './graphql/schema';

async function main() {
  await AppDataSource.initialize();
  await AppDataSource.runMigrations();
  await runSeedIfNeeded(AppDataSource);

  const yoga = createYoga({ schema: buildSchema(AppDataSource), graphqlEndpoint: '/graphql' });

  const app = new Elysia({ adapter: node() })
    .get('/health', () => ({ status: 'ok' }))
    .all('/graphql', ({ request }) => yoga.fetch(request))
    .listen(env.PORT);

  console.log(`denpa_memo server listening on http://localhost:${env.PORT}/graphql`);
  return app;
}

main().catch((error) => {
  console.error('Failed to start server', error);
  process.exit(1);
});
