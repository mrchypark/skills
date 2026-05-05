# Codex Toolkit

Personal Codex toolkit repository for `mrchypark`.

This repository is the source of truth for:

- Codex skills under `skills/`
- principal-team evaluation fixtures under `evals/`
- multi-agent config templates under `codex/`
- install helpers under `install/`
- deterministic helpers under `scripts/`
- project vendoring templates under `templates/project/`
- validation scripts under `tests/`

The repository keeps a development-friendly layout. Install scripts project that layout into the Codex-visible surfaces:

- `~/.agents/skills/<repo-name>`
- `~/.codex/<repo-name>`
- project-local `.agents/`, `.codex/`, and `AGENTS.md`

No repository-owned hook layer is included. The toolkit only models Codex surfaces that are actually installed or checked into a project.

The default operating surface is intentionally small:

- eight process skills
- seven domain skills
- seven bundled agent roles

The larger external reference catalogs are inventoried for comparison, then aggressively reduced before anything is installed here.

## Structure

```text
evals/
skills/
  process/
  domain/
codex/
  AGENTS.md
  config.toml
  agents/
  context/
install/
templates/project/
tests/
catalog/registry.yaml
```

## Included Skills

### Process

- `codex-principal-team`
- `harvest-work-patterns`
- `review-loop`
- `remote-review`
- `review-workflow`
- `memory-harvest`
- `scheduled-task`
- `skill-management`

### Domain

- `disk-clean-audit`
- `oracle`
- `pocketbase-go`
- `legacy-automation`
- `frontend-design`
- `ui-ux-pro-max`
- `yeoul-memory`

## Bundled Agents

- `triager`
- `builder`
- `cost_analyst`
- `debater`
- `moderator`
- `researcher`
- `reviewer`

## Install

Global install:

```bash
sh install/global-install.sh "$(pwd)"
sh install/verify-install.sh "$(pwd)"
```

Restart Codex after changing the global install layout.

To sync repo-managed skills into Codex's direct local skill path:

```bash
sh install/sync-codex-skills.sh "$(pwd)"
```

Project bootstrap:

```bash
sh install/project-bootstrap.sh "$(pwd)" /path/to/project
```

## Verify

```bash
tests/validate-repo.sh
tests/smoke-install.sh
```

## Reference Inventory

To re-list the external reference skills and agents and refresh the consolidation worksheet:

```bash
python3 scripts/reference_inventory.py \
  --json-out catalog/reference-inventory.json \
  --markdown-out docs/reference-consolidation.md
tests/reference-inventory.sh
```

The consolidation findings that explain what was kept, simplified, or rejected live in `docs/codex-fit-review.md`.
