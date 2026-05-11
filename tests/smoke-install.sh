#!/bin/sh
set -eu

ROOT=$(CDPATH= cd -- "$(dirname "$0")/.." && pwd)
TMPDIR=$(mktemp -d)
HOME_DIR="$TMPDIR/home"
PROJECT_DIR="$TMPDIR/project"
TARGET_DIR="$TMPDIR/consumer"
REPO_NAME=$(basename "$PROJECT_DIR")

cleanup() {
  rm -rf "$TMPDIR"
}
trap cleanup EXIT INT TERM

mkdir -p "$HOME_DIR" "$PROJECT_DIR" "$TARGET_DIR"
cp -R "$ROOT/." "$PROJECT_DIR"

HOME="$HOME_DIR" sh "$PROJECT_DIR/install/global-install.sh" "$PROJECT_DIR"
HOME="$HOME_DIR" sh "$PROJECT_DIR/install/verify-install.sh" "$PROJECT_DIR"
HOME="$HOME_DIR" sh "$PROJECT_DIR/install/project-bootstrap.sh" "$PROJECT_DIR" "$TARGET_DIR"

[ -L "$HOME_DIR/.agents/skills/$REPO_NAME" ] || {
  printf 'missing global skills symlink\n' >&2
  exit 1
}
[ -f "$HOME_DIR/.codex/$REPO_NAME/config.toml" ] || {
  printf 'missing copied codex config\n' >&2
  exit 1
}
[ -f "$HOME_DIR/.codex/$REPO_NAME/agents/triager.toml" ] || {
  printf 'missing copied triager config\n' >&2
  exit 1
}
[ -f "$HOME_DIR/.codex/$REPO_NAME/agents/cost-analyst.toml" ] || {
  printf 'missing copied cost-analyst config\n' >&2
  exit 1
}
[ -L "$HOME_DIR/.codex/skills/codex-principal-team" ] || {
  printf 'missing synced codex-principal-team symlink\n' >&2
  exit 1
}
[ "$(readlink "$HOME_DIR/.codex/skills/codex-principal-team")" = "$PROJECT_DIR/skills/process/codex-principal-team" ] || {
  printf 'codex-principal-team symlink target mismatch\n' >&2
  exit 1
}
[ -L "$HOME_DIR/.codex/skills/harvest-work-patterns" ] || {
  printf 'missing synced harvest-work-patterns symlink\n' >&2
  exit 1
}
[ -L "$HOME_DIR/.codex/skills/skill-management" ] || {
  printf 'missing synced skill-management symlink\n' >&2
  exit 1
}
[ -L "$HOME_DIR/.codex/skills/remote-review" ] || {
  printf 'missing synced remote-review symlink\n' >&2
  exit 1
}
[ "$(readlink "$HOME_DIR/.codex/skills/remote-review")" = "$PROJECT_DIR/skills/process/remote-review" ] || {
  printf 'remote-review symlink target mismatch\n' >&2
  exit 1
}
[ -L "$HOME_DIR/.codex/skills/frontend-design" ] || {
  printf 'missing synced frontend-design symlink\n' >&2
  exit 1
}
for dst in "$HOME_DIR/.codex/skills"/*; do
  [ -e "$dst" ] || continue
  if [ -L "$dst" ] && [ ! -e "$dst" ]; then
    printf 'broken synced skill symlink: %s -> %s\n' "$dst" "$(readlink "$dst")" >&2
    exit 1
  fi
done
[ -f "$TARGET_DIR/AGENTS.md" ] || {
  printf 'missing bootstrapped AGENTS.md\n' >&2
  exit 1
}
[ -f "$TARGET_DIR/.codex/config.toml" ] || {
  printf 'missing bootstrapped project codex config\n' >&2
  exit 1
}
[ -f "$TARGET_DIR/.codex/agents/reviewer.toml" ] || {
  printf 'missing bootstrapped project reviewer config\n' >&2
  exit 1
}
[ -f "$TARGET_DIR/.codex/agents/cost-analyst.toml" ] || {
  printf 'missing bootstrapped project cost-analyst config\n' >&2
  exit 1
}
[ -f "$TARGET_DIR/.agents/skills/README.md" ] || {
  printf 'missing bootstrapped project skills README\n' >&2
  exit 1
}
