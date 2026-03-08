# mrchypark/skills

Personal skill repository for `mrchypark`.

Skills can live at the repository root or under capability namespaces when the same tool needs service-specific variants.

## Structure

- `docs/plans/`: design and implementation notes for repository changes
- `oracle/`: shared Oracle family with service-specific variants for ChatGPT, Claude, and Gemini
- `pocketbase-go/`: PocketBase backend skill for Go projects

## Current Skills

- `oracle`
- `oracle/chatgpt`
- `oracle/claude`
- `oracle/gemini`
- `pocketbase-go`

## Adding Skills

Add each new skill either at the repository root or inside a capability namespace:

```text
skills/
├── README.md
├── oracle/
│   ├── SKILL.md
│   ├── chatgpt/
│   │   ├── SKILL.md
│   │   └── agents/
│   ├── claude/
│   │   └── SKILL.md
│   └── gemini/
│       └── SKILL.md
├── docs/
└── <skill-name>/
    ├── SKILL.md
    └── resources/
```

Keep each capability and each service variant self-contained inside its own directory.
