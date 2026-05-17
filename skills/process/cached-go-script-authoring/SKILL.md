---
name: cached-go-script-authoring
description: Use when creating personal skill helper tools in Go that should live beside a skill, build on demand, cache their binaries, and use external Go module dependencies.
---

# Cached Go Script Authoring

Use this for personal skill helpers that need Go libraries, speed, or stronger typing than shell. The default shape is a shell launcher plus a normal Go module source directory. Do not use a direct Go shebang in `.go` files.

## Layout

```text
skills/.../my-skill/
  scripts/
    my-tool              # shell launcher, executable entrypoint
    my-tool-src/
      go.mod
      go.sum
      main.go
```

`go.mod` and `go.sum` are part of the tool source. External dependencies are expected by default; pin them through normal Go module versions. Run `go mod tidy` before relying on cache behavior so the launcher does not create `go.sum` during the first execution and then compute a different cache key on the next run.

## Authoring Flow

1. Create `scripts/<tool>-src` and initialize the module:
   ```bash
   cd scripts/my-tool-src
   go mod init example.com/personal/my-tool
   go get github.com/some/dependency@latest
   go mod tidy
   ```
2. Put all implementation in `main.go` and normal package files under `<tool>-src`.
3. Add a POSIX shell launcher at `scripts/<tool>` that builds the module into a cache and then `exec`s the cached binary.
4. Make only the launcher executable:
   ```bash
   chmod +x scripts/my-tool
   ```
5. In the skill body, tell agents to run the launcher, not `go run` by default.
6. Before committing, run `go test ./...` or at least the launcher once after `go mod tidy`; the second launcher run should reuse the cached binary.

## Launcher Pattern

```sh
#!/bin/sh
set -eu

TOOL_NAME=$(basename "$0")
SCRIPT_PATH=$(readlink -f "$0" 2>/dev/null || realpath "$0" 2>/dev/null || printf '%s\n' "$0")
SCRIPT_DIR=$(CDPATH= cd -- "$(dirname "$SCRIPT_PATH")" && pwd)
SRC_DIR="$SCRIPT_DIR/$TOOL_NAME-src"
CACHE_ROOT="${CODEX_GO_SCRIPT_CACHE:-${XDG_CACHE_HOME:-$HOME/.cache}/codex-go-scripts}"
PLATFORM=$(go env GOOS GOARCH | tr '\n' '-' | sed 's/-$//')
KEY=$(
  cd "$SRC_DIR" && {
    go env GOVERSION GOOS GOARCH GOWORK GOFLAGS CGO_ENABLED GOEXPERIMENT CC CXX
    if command -v shasum >/dev/null 2>&1; then
      find . -type d \( \( -name ".*" ! -name "." \) -o -name "vendor" \) -prune -o -type f ! -name ".*" -exec shasum -a 256 {} + | sort
    else
      find . -type d \( \( -name ".*" ! -name "." \) -o -name "vendor" \) -prune -o -type f ! -name ".*" -exec sha256sum {} + | sort
    fi
  } | if command -v shasum >/dev/null 2>&1; then
    shasum -a 256
  else
    sha256sum
  fi | awk '{print $1}'
)
BIN_DIR="$CACHE_ROOT/$TOOL_NAME/$PLATFORM/$KEY"
BIN="$BIN_DIR/$TOOL_NAME"

if [ "${CACHED_GO_REBUILD:-0}" = "1" ] || [ ! -x "$BIN" ]; then
  mkdir -p "$BIN_DIR"
  [ "${CACHED_GO_DEBUG:-0}" = "1" ] && printf 'building %s\n' "$BIN" >&2
  TMP="$BIN.tmp.$$"
  rm -f "$TMP"
  trap 'rm -f "$TMP"' 0
  (cd "$SRC_DIR" && go mod download && go build -trimpath -o "$TMP" .)
  mv "$TMP" "$BIN"
  trap - 0
fi

exec "$BIN" "$@"
```

## Guardrails

- Keep this personal-use focused: optimize for repeatability and easy local debugging, not public packaging.
- Use `CODEX_GO_SCRIPT_CACHE=/path` only when overriding the default personal cache location.
- Commit `go.mod`, `go.sum`, source files, and the shell launcher. Do not commit cached binaries.
- Do not vendor dependencies into `<tool>-src`; the launcher pattern relies on `go.mod`, `go.sum`, and `go mod download`.
- Prefer one command per launcher. Add another launcher and source dir when responsibilities diverge.
- Do not recommend `#!/usr/bin/env go run` or other direct Go shebang patterns in `.go` files.
