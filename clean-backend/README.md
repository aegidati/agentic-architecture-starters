# clean-backend starter

`clean-backend` is a minimal, production-like backend starter based on Clean Architecture (Ports & Adapters).

It is designed to be copied (or imported via git subtree) into a derived project under `app/`.

## Stack

- Node.js 20+
- TypeScript
- Fastify
- Vitest

## Architecture and dependency rules

This starter follows these layers:

- `app/src/domain` → core business concepts, no framework dependencies
- `app/src/application` → use cases and ports/interfaces, depends only on domain
- `app/src/infrastructure` → adapters implementing application ports
- `app/src/presentation` → HTTP layer (Fastify routes), depends on application/domain

Dependency rule:

- `domain` depends on nothing
- `application` depends on `domain` only
- `infrastructure` depends on `application` and `domain`
- `presentation` depends on `application` and `domain`

## Included behavior

- Health endpoint: `GET /health`
- Response: `{ "status": "ok" }`
- Automated in-memory test using Fastify `inject` (no real network port)

## Install this starter in a derived project

### Option 1: Copy files

Copy everything from:

- `clean-backend/app/*`

Into your derived project:

- `target-project/app/`

### Option 2: Git subtree

From your derived project repository root:

```bash
git subtree add --prefix=app <starter-repo> main --squash
```

Example with a named remote:

```bash
git remote add starters <path-or-url-to-agentic-architecture-starters>
git fetch starters
git subtree add --prefix=app starters main --squash
git subtree pull --prefix=app starters main --squash
```

If you only want this starter folder content, use a filtered branch or copy approach based on your workflow.

## Run locally

From `app/`:

```bash
npm install
npm run dev
```

Build and run:

```bash
npm run build
npm start
```

Run tests:

```bash
npm test
```

Run in-memory smoke check:

```bash
npm run smoke
```

## Where to put new features

For each new feature, map responsibilities by layer:

- Domain rules/value objects/entities → `src/domain`
- Use cases and required ports → `src/application`
- Implementations of ports (DB, external APIs, cache, queues) → `src/infrastructure`
- HTTP routes/controllers/plugins → `src/presentation`
- Composition/wiring → `src/main.ts`

## ADR note

After installing this starter into a derived project, create a project-specific **ADR-001** that documents architectural decisions for that project.
