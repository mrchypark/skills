#!/bin/sh
set -eu

REPO_ROOT=${1:-$(CDPATH= cd -- "$(dirname "$0")/.." && pwd)}
CODEX_SKILLS_ROOT=${2:-${HOME}/.codex/skills}
BACKUP_ROOT=${HOME}/.codex/skills-backups/sync-$(date +%Y%m%d-%H%M%S)

mkdir -p "$CODEX_SKILLS_ROOT"

skill_paths=$(
  sed -n '/kind: skill/{n; s/^    path: //p; }' "$REPO_ROOT/catalog/registry.yaml"
)

for relpath in $skill_paths; do
  skill_dir=$(dirname "$relpath")
  skill_name=$(basename "$skill_dir")
  src="$REPO_ROOT/$skill_dir"
  dst="$CODEX_SKILLS_ROOT/$skill_name"

  [ -f "$src/SKILL.md" ] || {
    printf 'missing skill source: %s\n' "$src/SKILL.md" >&2
    exit 1
  }

  case "$skill_name" in
    .system|codex-primary-runtime)
      printf 'refusing to manage reserved skill name: %s\n' "$skill_name" >&2
      exit 1
      ;;
  esac

  if [ -L "$dst" ]; then
    rm "$dst"
  elif [ -e "$dst" ]; then
    mkdir -p "$BACKUP_ROOT"
    rm -rf "$BACKUP_ROOT/$skill_name"
    mv "$dst" "$BACKUP_ROOT/$skill_name"
    printf 'Backed up existing %s to %s\n' "$dst" "$BACKUP_ROOT/$skill_name"
  fi

  ln -s "$src" "$dst"
  printf 'Linked %s -> %s\n' "$dst" "$src"
done

printf 'Synced Codex skills into %s\n' "$CODEX_SKILLS_ROOT"
