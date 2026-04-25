#!/bin/sh
set -eu

ROOT=$(CDPATH= cd -- "$(dirname "$0")/.." && pwd)
TMPDIR=$(mktemp -d)

cleanup() {
  rm -rf "$TMPDIR"
}
trap cleanup EXIT INT TERM

JSON_OUT="$TMPDIR/reference-inventory.json"
MD_OUT="$TMPDIR/reference-consolidation.md"

python3 "$ROOT/scripts/reference_inventory.py" \
  --json-out "$JSON_OUT" \
  --markdown-out "$MD_OUT"

[ -f "$JSON_OUT" ] || {
  printf 'missing json inventory output\n' >&2
  exit 1
}
[ -f "$MD_OUT" ] || {
  printf 'missing markdown inventory output\n' >&2
  exit 1
}

python3 - "$JSON_OUT" <<'PY'
import json
import sys

with open(sys.argv[1], "r", encoding="utf-8") as fh:
    data = json.load(fh)

repos = {source["id"] for source in data["sources"]}
assert "workflows" in repos
assert "awesome-claude-code-subagents" in repos

kinds = {entry["kind"] for entry in data["entries"]}
assert "skill" in kinds
assert "agent" in kinds

assert data["summary"]["total_entries"] > 50
PY

rg -q "Unified taxonomy" "$MD_OUT"
rg -q "workflows" "$MD_OUT"
rg -q "awesome-claude-code-subagents" "$MD_OUT"
