#!/bin/sh
set -eu

ROOT=$(CDPATH= cd -- "$(dirname "$0")/.." && pwd)

expect_path() {
  if [ ! -e "$ROOT/$1" ]; then
    printf 'missing required path: %s\n' "$1" >&2
    exit 1
  fi
}

expect_no_path() {
  if [ -e "$ROOT/$1" ]; then
    printf 'unexpected legacy path present: %s\n' "$1" >&2
    exit 1
  fi
}

expect_path "README.md"
expect_path "catalog/registry.yaml"
expect_path "codex/AGENTS.md"
expect_path "codex/config.toml"
expect_path "codex/agents/triager.toml"
expect_path "codex/agents/cost-analyst.toml"
expect_path "codex/agents/reviewer.toml"
expect_path "codex/agents/researcher.toml"
expect_path "install/global-install.sh"
expect_path "install/sync-codex-skills.sh"
expect_path "install/verify-install.sh"
expect_path "install/project-bootstrap.sh"
expect_path "scripts/analyze_codex_sessions.py"
expect_path "scripts/evaluate_team_run.py"
expect_path "skills/process/memory-harvest/SKILL.md"
expect_path "skills/process/codex-principal-team/SKILL.md"
expect_path "skills/process/codex-principal-team/scripts/analyze_codex_sessions.py"
expect_path "skills/process/codex-principal-team/scripts/evaluate_team_run.py"
expect_path "skills/process/harvest-work-patterns/SKILL.md"
expect_path "skills/process/remote-review/SKILL.md"
expect_path "skills/process/review-loop/SKILL.md"
expect_path "skills/process/review-workflow/SKILL.md"
expect_path "skills/process/scheduled-task/SKILL.md"
expect_path "skills/process/skill-management/SKILL.md"
expect_path "skills/domain/disk-clean-audit/SKILL.md"
expect_path "skills/domain/oracle/SKILL.md"
expect_path "skills/domain/pocketbase-go/SKILL.md"
expect_path "skills/domain/legacy-automation/SKILL.md"
expect_path "skills/domain/frontend-design/SKILL.md"
expect_path "skills/domain/ui-ux-pro-max/SKILL.md"
expect_path "skills/domain/yeoul-memory/SKILL.md"
expect_path "templates/project/AGENTS.md"
expect_path "templates/project/.codex/config.toml"
expect_path "templates/project/.codex/agents/triager.toml"
expect_path "templates/project/.codex/agents/cost-analyst.toml"
expect_path "templates/project/.codex/agents/reviewer.toml"
expect_path "templates/project/.codex/agents/researcher.toml"
expect_path "templates/project/.agents/skills/README.md"

sed -n 's/^    path: //p' "$ROOT/catalog/registry.yaml" | while IFS= read -r relpath; do
  [ -n "$relpath" ] || continue
  if [ ! -e "$ROOT/$relpath" ]; then
    printf 'registry path missing: %s\n' "$relpath" >&2
    exit 1
  fi
done

expect_no_path "disk-clean-audit/chatgpt"
expect_no_path "disk-clean-audit/claude"
expect_no_path "disk-clean-audit/gemini"
expect_no_path "oracle/chatgpt"
expect_no_path "oracle/claude"
expect_no_path "oracle/gemini"
