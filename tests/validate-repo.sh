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
expect_path "codex/agents/reviewer.toml"
expect_path "codex/agents/researcher.toml"
expect_path "codex/agents/trend-researcher.toml"
expect_path "codex/agents/keyword-curator.toml"
expect_path "codex/prompts/business-ideation-keywords.md"
expect_path "install/global-install.sh"
expect_path "install/verify-install.sh"
expect_path "install/project-bootstrap.sh"
expect_path "skills/process/mrchypark-brainstorm/SKILL.md"
expect_path "skills/process/mrchypark-plan/SKILL.md"
expect_path "skills/process/mrchypark-delegate/SKILL.md"
expect_path "skills/process/mrchypark-review-request/SKILL.md"
expect_path "skills/process/mrchypark-verify/SKILL.md"
expect_path "skills/domain/disk-clean-audit/SKILL.md"
expect_path "skills/domain/oracle/SKILL.md"
expect_path "skills/domain/pocketbase-go/SKILL.md"
expect_path "templates/project/AGENTS.md"
expect_path "templates/project/.codex/config.toml"
expect_path "templates/project/.codex/agents/triager.toml"
expect_path "templates/project/.codex/agents/reviewer.toml"
expect_path "templates/project/.codex/agents/researcher.toml"
expect_path "templates/project/.codex/agents/trend-researcher.toml"
expect_path "templates/project/.codex/agents/keyword-curator.toml"
expect_path "templates/project/.codex/prompts/business-ideation-keywords.md"
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
