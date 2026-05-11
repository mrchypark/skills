#!/bin/sh
set -eu

REPO_ROOT=${1:-$(CDPATH= cd -- "$(dirname "$0")/.." && pwd)}
REPO_NAME=${2:-$(basename "$REPO_ROOT")}
SKILLS_ROOT=${HOME}/.agents/skills
CODEX_ROOT=${HOME}/.codex/${REPO_NAME}
SKILL_LINK=${SKILLS_ROOT}/${REPO_NAME}

mkdir -p "$SKILLS_ROOT"
mkdir -p "${HOME}/.codex"

if [ -L "$SKILL_LINK" ] || [ -e "$SKILL_LINK" ]; then
  rm -rf "$SKILL_LINK"
fi
ln -s "$REPO_ROOT/skills" "$SKILL_LINK"

mkdir -p "$CODEX_ROOT"
cp -R "$REPO_ROOT/codex/." "$CODEX_ROOT/"

sh "$REPO_ROOT/install/sync-codex-skills.sh" "$REPO_ROOT"

printf 'Installed skills at %s\n' "$SKILL_LINK"
printf 'Installed Codex config at %s\n' "$CODEX_ROOT"
