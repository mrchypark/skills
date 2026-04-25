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
[ -f "$CODEX_ROOT/agents/reviewer.toml" ] || {
  printf 'missing installed reviewer config\n' >&2
  exit 1
}
[ -f "$CODEX_ROOT/agents/researcher.toml" ] || {
  printf 'missing installed researcher config\n' >&2
  exit 1
}
[ -L "${HOME}/.codex/skills/skill-management" ] || {
  printf 'missing synced skill-management skill\n' >&2
  exit 1
}
[ -L "${HOME}/.codex/skills/yeoul-memory" ] || {
  printf 'missing synced yeoul-memory skill\n' >&2
  exit 1
}

printf 'Install verified for %s\n' "$REPO_NAME"
