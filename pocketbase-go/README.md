# PocketBase Go Skill

This skill provides a robust, atomic, and type-safe workflow for managing PocketBase backends in Go projects. It automates schema migration, code generation, and environment setup.

In this repository, the skill lives under [`pocketbase-go/`](./).

## Installation

### Option 1: Copy the Skill Directory

Copy the `pocketbase-go/` directory into your local skills directory.

### Option 2: Copy from This Repository

If you want to vendor only this skill into another repository, copy or sync the `pocketbase-go/` directory into your target skills folder.

```bash
mkdir -p ~/.codex/skills
cp -R pocketbase-go ~/.codex/skills/pocketbase-go
```

### Option 3: Git Submodule

If you prefer vendoring the whole personal skills repository as a submodule:

```bash
git submodule add https://github.com/mrchypark/skills.git vendor/mrchypark-skills
cp -R vendor/mrchypark-skills/pocketbase-go ~/.codex/skills/pocketbase-go
```

### Option 4: Clone Directly

If you want the full personal skills repository, clone it and use the `pocketbase-go/` subdirectory:

```bash
git clone https://github.com/mrchypark/skills.git
```

## Usage

1.  **Load the Skill**: Tell your AI agent "Use the PocketBase Go skill".
2.  **Initialize**: The agent will run `make init` to setup the environment.
3.  **Manage Schema**: Ask the agent to "Create a posts collection" or "Add a title field to posts".
4.  **Sync**: The agent will run `make sync` to update `pb_schema.json` and generate Go code.

## Requirements

*   **Go 1.21+**: Required for `pbc-gen`.
*   **Python 3**: Required for the migration script.
*   **Make**: Required for the build system.
*   **Docker**: (Optional) For containerized deployment.

## Repository Structure

```text
skills/
├── README.md
└── pocketbase-go/
    ├── SKILL.md
    ├── README.md
    └── resources/
        ├── Makefile
        ├── pb_migrate_ops.py
        └── Dockerfile
```
