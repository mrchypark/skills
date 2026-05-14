---
name: cached-go-script-usage
description: Use when running, debugging, rebuilding, or clearing caches for personal skill helper tools implemented as shell-launched cached Go modules.
---

# Cached Go Script Usage

Use the shell launcher as the tool entrypoint. The Go source directory exists for debugging and maintenance; normal skill instructions should run `scripts/<tool>`.

## Run

```bash
skills/.../my-skill/scripts/my-tool --help
skills/.../my-skill/scripts/my-tool <args>
```

On first run, the launcher builds the Go module from `scripts/<tool>-src` into `${CODEX_GO_SCRIPT_CACHE:-${XDG_CACHE_HOME:-$HOME/Library/Caches}/codex-go-scripts}/...` and then executes the cached binary. Later runs reuse the binary until source, `go.mod`, `go.sum`, Go version, platform, or build-affecting Go environment changes. The default key includes `GOFLAGS`, `CGO_ENABLED`, `GOEXPERIMENT`, `CC`, and `CXX`. If `go.sum` was missing and the first run created it, run `go mod tidy`, commit `go.sum`, and expect one more rebuild because the cache key correctly changed.

## Debug

```bash
CACHED_GO_DEBUG=1 skills/.../my-skill/scripts/my-tool <args>
CACHED_GO_REBUILD=1 skills/.../my-skill/scripts/my-tool <args>
CODEX_GO_SCRIPT_CACHE=/tmp/codex-go-scripts skills/.../my-skill/scripts/my-tool <args>
```

For source-level checks, work inside the module directory:

```bash
cd skills/.../my-skill/scripts/my-tool-src
go test ./...
go run . <args>
go mod tidy
```

`go run .` is for debugging the module directly. Do not replace the launcher with a Go shebang in `.go` files.

## Clear Caches

Clear one tool cache:

```bash
rm -rf "${CODEX_GO_SCRIPT_CACHE:-${XDG_CACHE_HOME:-$HOME/Library/Caches}/codex-go-scripts}/my-tool"
```

Clear all personal cached Go skill tools:

```bash
rm -rf "${CODEX_GO_SCRIPT_CACHE:-${XDG_CACHE_HOME:-$HOME/Library/Caches}/codex-go-scripts}"
```

## Failure Checks

- `go: command not found`: install Go or use a non-Go helper.
- Dependency errors: inspect `go.mod` and `go.sum`, then run `go mod tidy` in `<tool>-src`.
- Stale behavior: run with `CACHED_GO_REBUILD=1`, then clear the tool cache if needed.
- Permission denied: `chmod +x scripts/<tool>`.
- Do not edit cached binaries; edit the source dir and rerun the launcher.
