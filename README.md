# mrchypark/skills

Personal skill repository for `mrchypark`.

Skills can live at the repository root or under platform-specific namespaces when the same capability needs different packaging rules.

## Structure

- `docs/plans/`: design and implementation notes for repository changes
- `gpt/`: GPT/Codex-oriented skills written in the richer `skill-creator` style
- `claude-code/`: Claude Code-oriented skills written as `SKILL.md`-first variants
- `pocketbase-go/`: PocketBase backend skill for Go projects

## Current Skills

- `gpt/oracle`
- `claude-code/oracle`
- `pocketbase-go`

## Adding Skills

Add each new skill either at the repository root or inside a platform namespace:

```text
skills/
├── README.md
├── gpt/
│   └── <skill-name>/
│       ├── SKILL.md
│       └── agents/
├── claude-code/
│   └── <skill-name>/
│       └── SKILL.md
├── docs/
└── <skill-name>/
    ├── SKILL.md
    └── resources/
```

Keep each variant self-contained inside its own skill directory.
