# Codex Toolkit

Personal Codex toolkit repository for `mrchypark`.

This repository is the source of truth for:

- Codex skills under `skills/`
- multi-agent config templates under `codex/`
- install helpers under `install/`
- project vendoring templates under `templates/project/`
- validation scripts under `tests/`

The repository keeps a development-friendly layout. Install scripts project that layout into the Codex-visible surfaces:

- `~/.agents/skills/<repo-name>`
- `~/.codex/<repo-name>`
- project-local `.agents/`, `.codex/`, and `AGENTS.md`

No repository-owned hook layer is included. The toolkit only models Codex surfaces that are actually installed or checked into a project.

The default operating surface is intentionally small:

- four process skills
- four domain skills
- six bundled agent roles

The larger external reference catalogs are inventoried for comparison, then aggressively reduced before anything is installed here.

## Structure

```text
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

- `review-loop`
- `remote-review`
- `memory-harvest`
- `scheduled-task`

### Domain

- `disk-clean-audit`
- `oracle`
- `pocketbase-go`
- `legacy-automation`

## Bundled Agents

- `triager`
- `builder`
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
