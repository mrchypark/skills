#!/bin/sh
set -eu

REPO_ROOT=${1:-$(CDPATH= cd -- "$(dirname "$0")/.." && pwd)}
REPO_NAME=${2:-$(basename "$REPO_ROOT")}
SKILL_LINK=${HOME}/.agents/skills/${REPO_NAME}
CODEX_ROOT=${HOME}/.codex/${REPO_NAME}

[ -L "$SKILL_LINK" ] || {
  printf 'missing skills symlink: %s\n' "$SKILL_LINK" >&2
  exit 1
}
[ "$(readlink "$SKILL_LINK")" = "$REPO_ROOT/skills" ] || {
  printf 'skills symlink target mismatch\n' >&2
  exit 1
}
[ -f "$CODEX_ROOT/AGENTS.md" ] || {
  printf 'missing installed AGENTS.md\n' >&2
  exit 1
}
[ -f "$CODEX_ROOT/config.toml" ] || {
  printf 'missing installed config.toml\n' >&2
  exit 1
}
[ -f "$CODEX_ROOT/agents/triager.toml" ] || {
  printf 'missing installed triager config\n' >&2
  exit 1
}
[ -f "$CODEX_ROOT/agents/cost-analyst.toml" ] || {
  printf 'missing installed cost-analyst config\n' >&2
  exit 1
}
[ -f "$CODEX_ROOT/agents/reviewer.toml" ] || {
  printf 'missing installed reviewer config\n' >&2
  exit 1
}
[ -f "$CODEX_ROOT/agents/researcher.toml" ] || {
  printf 'missing installed researcher config\n' >&2
  exit 1
}

expect_synced_skill() {
  skill_name=$1
  expected_rel=$2
  dst="${HOME}/.codex/skills/${skill_name}"

  [ -L "$dst" ] || {
    printf 'missing synced %s skill\n' "$skill_name" >&2
    exit 1
  }
  [ "$(readlink "$dst")" = "$REPO_ROOT/$expected_rel" ] || {
    printf 'synced %s skill target mismatch\n' "$skill_name" >&2
    exit 1
  }
  [ -f "$dst/SKILL.md" ] || {
    printf 'synced %s skill is not readable\n' "$skill_name" >&2
    exit 1
  }
}

expect_synced_skill "remote-review" "skills/process/remote-review"
expect_synced_skill "review-workflow" "skills/process/review-workflow"
expect_synced_skill "codex-principal-team" "skills/process/codex-principal-team"
expect_synced_skill "harvest-work-patterns" "skills/process/harvest-work-patterns"
expect_synced_skill "skill-management" "skills/process/skill-management"
expect_synced_skill "oracle" "skills/domain/oracle"
expect_synced_skill "yeoul-memory" "skills/domain/yeoul-memory"

printf 'Install verified for %s\n' "$REPO_NAME"
