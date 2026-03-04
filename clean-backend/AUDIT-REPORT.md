# AUDIT REPORT — clean-backend

## 1) Metadata

- Date/time: 2026-03-04 14:53:01 +01:00
- Starter name: clean-backend
- Scope: clean-backend/**

## 2) Policy summary table

| Rule ID | Status | Notes | Files involved |
|---|---|---|---|
| P0 — Required files exist | PASS | All required files and layer directories exist, including at least one file in each required layer and at least one test file. | `clean-backend/README.md`, `clean-backend/app/package.json`, `clean-backend/app/tsconfig.json`, `clean-backend/app/src/main.ts`, `clean-backend/app/src/domain/health-status.ts`, `clean-backend/app/src/application/ports/health-check.port.ts`, `clean-backend/app/src/infrastructure/health/in-memory-health-check.adapter.ts`, `clean-backend/app/src/presentation/http/routes/health.routes.ts`, `clean-backend/app/test/health.test.ts`, `clean-backend/app/.env.example` |
| P1 — Dependency rule (imports) | PASS | Layer imports follow Clean Architecture dependency constraints; no forbidden cross-layer/framework imports in domain/application. | `clean-backend/app/src/domain/health-status.ts`, `clean-backend/app/src/application/ports/health-check.port.ts`, `clean-backend/app/src/application/use-cases/get-health-status.use-case.ts`, `clean-backend/app/src/infrastructure/health/in-memory-health-check.adapter.ts`, `clean-backend/app/src/presentation/http/routes/health.routes.ts`, `clean-backend/app/src/main.ts` |
| P2 — Health endpoint contract | PASS | `GET /health` returns HTTP 200 with JSON body `{ "status": "ok" }`. | `clean-backend/app/src/presentation/http/routes/health.routes.ts`, `clean-backend/app/src/infrastructure/health/in-memory-health-check.adapter.ts`, `clean-backend/app/test/health.test.ts` |
| P3 — Testing contract | PASS | At least one test covers `/health`, uses Fastify `inject`, and does not call `listen()` or bind to a real port. | `clean-backend/app/test/health.test.ts`, `clean-backend/app/src/main.ts` |
| P4 — Installability contract | PASS | README includes copy install path, git subtree workflow (add + pull), run instructions, layer mapping, and ADR-001 instruction. | `clean-backend/README.md` |

## 3) Findings (detailed)

### Finding F-001

- Rule ID: P4
- Description: README had git subtree installation instructions but did not explicitly include the `git subtree pull` update command.
- Evidence: `clean-backend/README.md` in section “Option 2: Git subtree” previously listed only `git subtree add --prefix app ...`.
- Remediation taken: Added `git subtree pull --prefix app starters main --squash` in the same section.

## 4) File change log

- Modified: `clean-backend/README.md` — added explicit `git subtree pull` command to satisfy P4 installability requirements.
- Created: `clean-backend/AUDIT-REPORT.md` — added complete policy-lint report for P0–P4.

## 5) Remaining risks / TODOs

- Non-blocking: `clean-backend/app/dist/` build artifacts are present in workspace and can be confused with starter source content when manually copying files. Consider excluding build artifacts from starter distribution workflow.
- Non-blocking: For long-term maintainability, consider adding automated import boundary linting (e.g., path rules) to enforce P1 continuously.
