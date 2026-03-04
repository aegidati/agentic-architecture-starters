# react-spa starter

`react-spa` is a minimal, production-like frontend starter for a full-stack setup.

It is designed to be installed into a derived project under `app/web/`.

## Stack

- Node.js 20+
- Vite + React + TypeScript
- `react-router-dom` for client-side routing
- Vitest + React Testing Library

## Included behavior

- Route `/` → `HomePage`
- Route `/health` → `HealthPage`
- `HealthPage` calls `GET ${VITE_API_BASE_URL}/health` using `fetch`
- Default backend base URL fallback: `http://localhost:3000`

## Install this starter in a derived project

### Option 1: Copy files

Copy everything from:

- `react-spa/app/*`

Into your derived project:

- `target/app/web/`

### Option 2: Git subtree

From your derived project repository root:

```bash
git subtree add --prefix=app/web <starter-repo> main --squash
git subtree pull --prefix=app/web <starter-repo> main --squash
```

Example with a named remote:

```bash
git remote add starters <path-or-url-to-agentic-architecture-starters>
git fetch starters
git subtree add --prefix=app/web starters main --squash
git subtree pull --prefix=app/web starters main --squash
```

## Configure backend base URL

Set `VITE_API_BASE_URL` in `.env` (or your environment):

```bash
VITE_API_BASE_URL=http://localhost:3000
```

A template is provided in `app/.env.example`.

## Run locally

From `app/`:

```bash
npm install
npm run dev
```

Build for production:

```bash
npm run build
```

Run tests:

```bash
npm test
```

## Feature placement guide

- App shell and route table: `src/app/`
- Route pages/components: `src/pages/`
- Backend HTTP calls / API wrappers: `src/services/`
- Global styles: `src/styles/`
- Automated tests: `test/`

## ADR note

After installing this starter into a derived project, create or accept project-specific **ADR-001** describing the chosen full-stack layout and boundaries.
