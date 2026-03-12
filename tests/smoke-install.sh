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
[ -f "$TARGET_DIR/.agents/skills/README.md" ] || {
  printf 'missing bootstrapped project skills README\n' >&2
  exit 1
}
