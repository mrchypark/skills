#!/bin/sh
set -eu

REPO_ROOT=${1:-$(CDPATH= cd -- "$(dirname "$0")/.." && pwd)}
TARGET_DIR=${2:?target project directory is required}
TEMPLATE_DIR="$REPO_ROOT/templates/project"
CODEX_SOURCE_DIR="$REPO_ROOT/codex"

mkdir -p "$TARGET_DIR"
cp -R "$TEMPLATE_DIR/." "$TARGET_DIR/"
mkdir -p "$TARGET_DIR/.codex"
cp -R "$CODEX_SOURCE_DIR/." "$TARGET_DIR/.codex/"

printf 'Bootstrapped project template into %s\n' "$TARGET_DIR"
