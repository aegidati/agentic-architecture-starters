# postgres-dev starter

`postgres-dev` is a minimal, Docker Compose-based PostgreSQL development database setup.

It is stack-agnostic and designed to be installed into a derived project under `app/infra/`.

## What is this?

A ready-to-use Docker Compose configuration for a local PostgreSQL database, including:
- PostgreSQL 16 container with default dev credentials.
- Named volume for data persistence.
- Environment variable configuration for flexibility.
- Helper scripts for common operations: `up`, `down`, `reset`.

## Prerequisites

- Docker and Docker Compose installed.
- Available port 5432 on localhost (or configure `POSTGRES_PORT` in `.env`).

## Install this starter in a derived project

### Option 1: Copy files

Copy everything from:

- `postgres-dev/app/*`

Into your derived project:

- `target-project/app/infra/`

### Option 2: Git subtree

From your derived project repository root:

```bash
git subtree add --prefix=app/infra <starter-repo> main --squash
git subtree pull --prefix=app/infra <starter-repo> main --squash
```

Example with a named remote:

```bash
git remote add starters <path-or-url-to-agentic-architecture-starters>
git fetch starters
git subtree add --prefix=app/infra starters main --squash
git subtree pull --prefix=app/infra starters main --squash
```

## Configuration

All configuration is via environment variables in `.env` (or your environment).

Template: `.env.example`

Key variables:
- `POSTGRES_DB` — database name (default: app_dev)
- `POSTGRES_USER` — superuser name (default: app)
- `POSTGRES_PASSWORD` — superuser password (default: app)
- `POSTGRES_HOST` — host (default: localhost)
- `POSTGRES_PORT` — port (default: 5432)

**⚠️ IMPORTANT:** These defaults are for development only. Change credentials before any production use.

## Start / Stop / Reset

From `app/infra/` directory:

### Start database

```bash
./scripts/up.sh
```

The container will start in detached mode. Logs can be viewed with:

```bash
docker-compose logs -f
```

### Stop database

```bash
./scripts/down.sh
```

Containers stop; volume persists.

### Reset database (drop all data)

```bash
./scripts/reset.sh
```

⚠️ This is DANGEROUS. It removes the volume and all data; use only in development.

## DATABASE_URL examples

After configuring `.env`, use the `DATABASE_URL` format appropriate to your backend:

### Generic format (for tools like Prisma, TypeORM, SQLAlchemy):

```
postgresql://app:app@localhost:5432/app_dev
```

Or from `.env.example`:

```bash
DATABASE_URL=postgresql://${POSTGRES_USER}:${POSTGRES_PASSWORD}@${POSTGRES_HOST}:${POSTGRES_PORT}/${POSTGRES_DB}
```

### Node.js (node-postgres, pg):

```javascript
const { Pool } = require('pg');
const pool = new Pool({
  user: process.env.POSTGRES_USER,
  password: process.env.POSTGRES_PASSWORD,
  host: process.env.POSTGRES_HOST,
  port: parseInt(process.env.POSTGRES_PORT || '5432'),
  database: process.env.POSTGRES_DB
});
```

### Python (psycopg2, SQLAlchemy):

```python
import os
from sqlalchemy import create_engine

DATABASE_URL = f"postgresql://{os.getenv('POSTGRES_USER')}:{os.getenv('POSTGRES_PASSWORD')}@{os.getenv('POSTGRES_HOST')}:{os.getenv('POSTGRES_PORT', 5432)}/{os.getenv('POSTGRES_DB')}"
engine = create_engine(DATABASE_URL)
```

### Go (pq, pgx):

```go
import "fmt"
import "os"

dsn := fmt.Sprintf(
  "postgres://%s:%s@%s:%s/%s?sslmode=disable",
  os.Getenv("POSTGRES_USER"),
  os.Getenv("POSTGRES_PASSWORD"),
  os.Getenv("POSTGRES_HOST"),
  os.Getenv("POSTGRES_PORT"),
  os.Getenv("POSTGRES_DB"),
)
```

### .NET (Npgsql, Entity Framework):

```csharp
var connectionString = $"Host={Environment.GetEnvironmentVariable("POSTGRES_HOST")};Port={Environment.GetEnvironmentVariable("POSTGRES_PORT")};Database={Environment.GetEnvironmentVariable("POSTGRES_DB")};Username={Environment.GetEnvironmentVariable("POSTGRES_USER")};Password={Environment.GetEnvironmentVariable("POSTGRES_PASSWORD")}";
```

## ADR note

After installing this starter into a derived project, consider creating or updating **ADR-001** to document:
- Database initialization strategy (migrations, seed data).
- Credentials management for different environments (dev/staging/prod).
- Backup/restore procedures.
