# mrchypark/skills

Personal skill repository for `mrchypark`.

Skills can live at the repository root or under capability namespaces when the same tool needs service-specific variants.

## Structure

- `disk-clean-audit/`: shared disk cleanup audit family with service-specific variants
- `docs/plans/`: design and implementation notes for repository changes
- `oracle/`: shared Oracle family with service-specific variants for ChatGPT, Claude, and Gemini
- `review-loop/`: repeated layer-based review and revision workflow for plans and code
- `pocketbase-go/`: PocketBase backend skill for Go projects

## Current Skills

- `disk-clean-audit`
- `disk-clean-audit/chatgpt`
- `disk-clean-audit/claude`
- `disk-clean-audit/gemini`
- `oracle`
- `oracle/chatgpt`
- `oracle/claude`
- `oracle/gemini`
- `review-loop`
- `pocketbase-go`

## Adding Skills

Add each new skill either at the repository root or inside a capability namespace:

```text
skills/
├── README.md
├── disk-clean-audit/
│   ├── SKILL.md
│   ├── chatgpt/
│   │   ├── SKILL.md
│   │   └── agents/
│   ├── claude/
│   │   └── SKILL.md
│   └── gemini/
│       └── SKILL.md
├── oracle/
│   ├── SKILL.md
│   ├── chatgpt/
│   │   ├── SKILL.md
│   │   └── agents/
│   ├── claude/
│   │   └── SKILL.md
│   └── gemini/
│       └── SKILL.md
├── review-loop/
│   └── SKILL.md
├── docs/
└── <skill-name>/
    ├── SKILL.md
    └── resources/
```

Keep each capability and each service variant self-contained inside its own directory.
