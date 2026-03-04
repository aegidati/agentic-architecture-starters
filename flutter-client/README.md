# flutter-client starter

`flutter-client` is a minimal Flutter starter following Clean Architecture.

It can be used standalone or copied into a derived full-stack project under `app/client`.

## Purpose

Provide a runnable Flutter client with:

- `HomePage` and `HealthPage`
- clean layer boundaries (`domain`, `application`, `infrastructure`, `presentation`)
- a health check flow calling backend `GET /health`
- unit and widget tests without real network calls

## Folder structure and dependency rules

Core app code lives in `app/lib`:

- `domain/` → pure Dart business models, no Flutter/external package dependencies
- `application/` → use cases and ports, depends only on `domain`
- `infrastructure/` → adapters implementing application ports (HTTP repository)
- `presentation/` → Flutter UI, routing, state management

Dependency direction:

- `domain` depends on nothing
- `application` depends on `domain`
- `infrastructure` depends on `application` and `domain`
- `presentation` depends on `application` (and may read domain models through application results)

## Included routes

- `/` → `HomePage`
- `/health` → `HealthPage`

Routing uses `go_router`.

## Health flow

- Domain entity: `HealthStatus`
- Application port: `HealthRepository`
- Application use case: `HealthCheckUseCase`
- Infrastructure adapter: `HttpHealthRepository`
- Presentation state: `HealthController`

`HttpHealthRepository` calls:

- `GET {API_BASE_URL}/health`

Expected payload:

```json
{ "status": "ok" }
```

## Configure API base URL

The app reads backend URL using `--dart-define`:

- key: `API_BASE_URL`
- default fallback: `http://localhost:3000`

Example:

```bash
cd app
flutter run --dart-define=API_BASE_URL=http://localhost:3000
```

## Run locally

```bash
cd app
flutter pub get
flutter run
```

## Run tests

```bash
cd app
flutter test
```

Included tests:

- `test/unit/health_check_usecase_test.dart`
- `test/widget/health_page_test.dart`

## Run smoke check

This smoke check validates UI navigation from `/` to `/health` and verifies
health status rendering without real HTTP calls.

From `app/`:

```bash
flutter test test/widget/app_routing_smoke_test.dart
```

Or use helper scripts:

- PowerShell: `./scripts/smoke.ps1`
- Bash: `./scripts/smoke.sh`

## Install into a full-stack project

### Option 1: Copy files

Copy everything from:

- `flutter-client/app/*`

Into your target repository:

- `target-project/app/client/`

Then run in target folder:

```bash
cd app/client
flutter pub get
flutter run
```

### Option 2: Git subtree

From target repository root:

```bash
git remote add starters <path-or-url-to-agentic-architecture-starters>
git fetch starters
git subtree add --prefix=app/client starters main --squash
```

## ADR note

After installing this starter into a derived project, add a project-specific ADR describing Flutter layer boundaries and API integration rules.
