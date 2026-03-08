---
name: pocketbase-go
description: Use when managing a PocketBase backend in a Go project and you need safe schema changes, schema sync, or generated Go models.
---

# Instructions

You are an expert in PocketBase development using Go. You manage the backend by performing **atomic operations** on the database and syncing the state to code.

## Critical Rules

1.  **NO JSON Editing**: Never manually edit `pb_schema.json`. This is a generated file.
2.  **Tool First**: Always use the provided tools (`python3 pb_migrate_ops.py ...`) to modify the schema.
3.  **Sync Required**: After any schema change, run `make sync` immediately to update `pb_schema.json` and generate Go code.

## File Structure

-   `.pb/`: Contains the PocketBase binary and runtime data (gitignored).
-   `pb_migrations/`: Contains migration files (Should be committed to git).
-   `pb_hooks/`: Server-side JavaScript hooks (Should be committed to git).
-   `models/`: Generated Go code.
-   `pb_schema.json`: Schema snapshot for codegen.

## Workflow

0.  **Setup (First Time Only)**:
    -   Resolve this skill directory first, then copy the required files from `resources/` into the project root. Example: `SKILL_DIR=~/.codex/skills/pocketbase-go && cp "$SKILL_DIR"/resources/{Makefile,pb_migrate_ops.py,Dockerfile} .`
    -   Initialize environment: `make init` (This creates the admin user automatically)

1.  **Create Collection**:
    ```bash
    python3 pb_migrate_ops.py create_collection --name "posts" --type "base"
    ```
2.  **Add Field**:
    ```bash
    # Field definition must be valid JSON
    python3 pb_migrate_ops.py add_field --collection "posts" --field-json '{"name": "title", "type": "text", "required": true}'
    ```
3.  **Delete Field**:
    ```bash
    python3 pb_migrate_ops.py delete_field --collection "posts" --field-name "old_field"
    ```
4.  **Sync & Codegen** (Run this after ANY of the above):
    ```bash
    make sync
    ```

## Commands Reference

-   `make init`: Setup environment.
-   `make serve`: Start server.
-   `make sync`: Dump schema from DB -> `pb_schema.json` -> Generate Go code.

## Deployment (Docker)

A `Dockerfile` is provided in resources. It packages the PocketBase binary and your local `pb_migrations`.

1.  **Build**: `docker build -t my-pocketbase .`
2.  **Run**: `docker run -p 8090:8090 -v pb_data:/pb/pb_data my-pocketbase`

## Best Practices

-   **Verify First**: Before adding a field, check if the collection exists.
-   **One at a Time**: Perform one schema change at a time, then sync. This ensures your local state is always valid.
-   **Relations**: When adding relation fields, ensure the target collection ID or name is correct.
