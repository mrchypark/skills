# mrchypark/skills

Personal skill repository for `mrchypark`.

Each skill lives in its own top-level directory so the repository can grow as a flat monorepo without mixing skill assets together.

## Structure

- `docs/plans/`: design and implementation notes for repository changes
- `oracle/`: external model consultation skill via `@steipete/oracle`
- `pocketbase-go/`: PocketBase backend skill for Go projects

## Current Skills

- `oracle`
- `pocketbase-go`

## Adding Skills

Add each new skill as its own directory at the repository root:

```text
skills/
├── README.md
├── docs/
└── <skill-name>/
    ├── SKILL.md
    └── resources/
```

Keep `SKILL.md` and any supporting files inside that skill directory.
