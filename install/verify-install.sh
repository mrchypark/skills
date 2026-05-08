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

skill_paths=$(
  sed -n '/kind: skill/{n; s/^    path: //p; }' "$REPO_ROOT/catalog/registry.yaml"
)

for relpath in $skill_paths; do
  skill_dir=$(dirname "$relpath")
  skill_name=$(basename "$skill_dir")
  expect_synced_skill "$skill_name" "$skill_dir"
done

for dst in "${HOME}/.codex/skills"/*; do
  [ -e "$dst" ] || continue
  if [ -L "$dst" ] && [ ! -e "$dst" ]; then
    printf 'broken synced skill symlink: %s -> %s\n' "$dst" "$(readlink "$dst")" >&2
    exit 1
  fi
done

printf 'Install verified for %s\n' "$REPO_NAME"
