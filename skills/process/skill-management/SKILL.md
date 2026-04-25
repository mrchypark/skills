---
name: skill-management
description: Use when auditing, importing, renaming, removing, installing, or synchronizing local Codex skills and agent configs across machines.
---

# Skill Management

Use this repo as the source of truth for portable local skills and Codex agent configs.

## Surfaces

| Surface | Purpose |
|---|---|
| `skills/process/*/SKILL.md` | reusable workflow skills |
| `skills/domain/*/SKILL.md` | domain or tool-specific skills |
| `codex/agents/*.toml` | reusable Codex agent roles |
| `catalog/registry.yaml` | installable skill and agent inventory |
| `~/.codex/skills/<skill>` | Codex's direct local skill lookup path |
| `~/.agents/skills/<repo>` | repo-level skill symlink used by agent tooling |
| `~/.codex/<repo>/agents` | installed Codex agent configs |

## Import Workflow

1. Inventory local skills:
   ```bash
   find "$HOME/.codex/skills" -maxdepth 3 -type f -name SKILL.md | sort
   ```
2. Ignore system-managed skills under `~/.codex/skills/.system`.
3. Copy user-owned skills into `skills/process` or `skills/domain`.
4. Normalize frontmatter names to lowercase hyphen-case.
5. Remove stale source-specific prefixes when the skill is now generic.
6. Add each skill to `catalog/registry.yaml`.
7. Update `README.md` counts and lists.
8. Update validation tests for required paths.
9. Run install and validation scripts.

## Install Workflow

Use both install surfaces when this repo should be portable across machines:

```bash
sh install/global-install.sh "$(pwd)" codex-toolkit
sh install/sync-codex-skills.sh "$(pwd)"
sh install/verify-install.sh "$(pwd)" codex-toolkit
```

`sync-codex-skills.sh` symlinks registered repo skills into `~/.codex/skills`.
If a non-symlink skill already exists at the destination, it is moved into a timestamped backup directory under `~/.codex/skills-backups/`.

## Guardrails

- Do not edit `~/.codex/skills/.system`; those are system skills.
- Do not remove local skills without checking whether they were imported or intentionally excluded.
- Keep generated reference inventories separate from active installed skills.
- After renaming or deleting a skill, search all install surfaces for stale names.
- Prefer symlinks for local install so changes in this repo are visible immediately.

## Required Checks

```bash
tests/validate-repo.sh
tests/smoke-install.sh
tests/reference-inventory.sh
python3 - <<'PY'
from pathlib import Path
missing=[]
for line in Path('catalog/registry.yaml').read_text(encoding='utf-8').splitlines():
    s=line.strip()
    if s.startswith('path: '):
        p=s.split('path: ',1)[1]
        if not Path(p).exists():
            missing.append(p)
if missing:
    raise SystemExit('\n'.join(missing))
print('registry paths ok')
PY
```
