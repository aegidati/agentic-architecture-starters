# api-contracts-openapi starter

`api-contracts-openapi` is a minimal OpenAPI 3.1-based API contract specification for full-stack projects.

It is designed to be installed into a derived project under `app/contracts/`.

## What is this?

A contract-first approach to API development. This starter provides:

- A minimal OpenAPI 3.1 specification with the `/health` endpoint as a reference.
- Modular schema files (YAML) for reusability.
- A comprehensive `API-CONVENTIONS.md` document covering:
  - Routing and versioning strategy (/api/v1)
  - Naming conventions (kebab-case, nouns)
  - Standard HTTP methods and status codes
  - Error response format (RFC 7807 Problem Details)
  - Pagination and filtering guidelines
  - Authentication placeholders (Bearer, API Key, OAuth)
- A simple validation script to check spec syntax.

This starter is **stack-agnostic** and works with any backend or frontend framework.

## Prerequisites

For validation script:
- Node.js 18+ (for npx and @redocly/cli), OR
- `yq` CLI for YAML validation, OR
- Basic shell (fallback: grep check only)

## Install this starter in a derived project

### Option 1: Copy files

Copy everything from:

- `api-contracts-openapi/app/*`

Into your derived project:

- `target-project/app/contracts/`

### Option 2: Git subtree

From your derived project repository root:

```bash
git subtree add --prefix=app/contracts <starter-repo> main --squash
git subtree pull --prefix=app/contracts <starter-repo> main --squash
```

Example with a named remote:

```bash
git remote add starters <path-or-url-to-agentic-architecture-starters>
git fetch starters
git subtree add --prefix=app/contracts starters main --squash
git subtree pull --prefix=app/contracts starters main --squash
```

## Validate the spec

From `app/contracts/`:

```bash
./scripts/validate.sh
```

Output:
- `✓ OpenAPI spec is valid` (exit 0) — validation passed
- `✗ OpenAPI validation failed` (exit 1) — spec has issues

The script attempts validation in order:
1. **@redocly/cli** (preferred; comprehensive validation via npx)
2. **yq** (fallback; basic YAML check)
3. **grep** (last resort; checks for `openapi:` field)

## How to use this contract

### For frontend developers

1. Reference the OpenAPI spec locally or via a tool like Swagger UI:
   ```bash
   npx swagger-ui-dist <path>/openapi.yaml
   ```
   Or use [Swagger Editor](https://editor.swagger.io/) online.
2. Generate a client SDK (optional):
   ```bash
   npm install @openapitools/openapi-generator-cli
   openapi-generator-cli generate -i openapi.yaml -g typescript -o ./src/api
   ```
3. Use the generated client or fetch from endpoints listed in the spec.

### For backend developers

1. Implement endpoints as specified in `openapi.yaml`.
2. Ensure responses match the schemas in `openapi/schemas/`.
3. Follow conventions in `conventions/API-CONVENTIONS.md`.
4. Validate the spec before deployment:
   ```bash
   ./scripts/validate.sh
   ```

## How to extend this contract

When adding a new endpoint:

1. **Add the path definition to `openapi.yaml`**:
   ```yaml
   /api/v1/posts:
     get:
       summary: List all posts
       responses:
         '200':
           description: Posts list
           content:
             application/json:
               schema:
                 type: array
                 items:
                   $ref: ./schemas/Post.yaml
   ```

2. **Create a new schema file if needed**:
   ```bash
   # Create app/openapi/schemas/Post.yaml
   ```

3. **Update conventions if behavior deviates**:
   - Example: if your endpoint uses `_like` filtering differently, document it in `API-CONVENTIONS.md`.

4. **Validate and commit**:
   ```bash
   ./scripts/validate.sh
   git add openapi.yaml schemas/Post.yaml API-CONVENTIONS.md
   git commit -m "feat: add POST /api/v1/posts endpoint"
   ```

## ADR note

After installing this starter, derived projects should:
- Create or update **ADR-001** in the project to map this contract to their architecture.
- Document how the contract is used by frontend/backend teams.
- Establish a change control process (who approves contract changes).
- Consider versioning: when does a breaking change require `/api/v2`?

## Example API structure in a full-stack project

```
target-project/
  app/
    contracts/       ← this starter
      openapi/
        openapi.yaml
        schemas/
      conventions/
        API-CONVENTIONS.md
      scripts/
    backend/         ← implements the contract
      src/
        routes/
    frontend/        ← consumes the contract
      src/
        api/
        pages/
```

Both backend and frontend teams use `app/contracts/openapi.yaml` as the single source of truth.
