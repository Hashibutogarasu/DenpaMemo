FROM node:22-slim AS base
WORKDIR /app
RUN corepack enable

FROM base AS deps
COPY package.json pnpm-lock.yaml* ./
RUN pnpm install --frozen-lockfile || pnpm install

FROM deps AS dev
COPY . .
EXPOSE 4000
CMD ["pnpm", "run", "dev"]
