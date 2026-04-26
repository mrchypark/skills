---
name: oracle
description: Use when an important technical or product decision needs an external critique through the Oracle CLI before you finalize the direction.
---

# Oracle

## Overview

Use the installed `oracle` CLI as a second-opinion path for decisions that are expensive to reverse. In this environment, use browser mode with the dedicated Oracle Chrome profile on port `55268`; this is the verified stable path. Oracle output is advisory. Verify it against the codebase, local tests, and project constraints before adopting it.

## Use Oracle When

- architecture or API choices have lasting impact
- there are multiple viable approaches with unclear tradeoffs
- a migration or refactor is expensive to undo
- local reading and tests are unlikely to surface the main risks
- you want a second model to challenge assumptions before locking direction

## Do Not Use Oracle When

- the task is a routine edit or a small local bug
- the answer is available from a few files or local verification
- you are tempted to send a broad whole-repo review

## Workflow

1. Narrow the file set to the smallest useful scope.
2. Run `--dry-run` first and inspect the attached files.
3. State the current proposal, constraints, and at least one alternative.
4. Ask Oracle to critique assumptions, identify risks, and call out missing considerations.
5. Run browser mode with `--browser-port 55268`.
6. Reattach to detached browser sessions instead of re-running them.
7. Summarize the critique in your own words and decide what to verify locally before changing direction.

## Verified Commands

Dry run:

```bash
oracle --engine browser --browser-port 55268 \
  --dry-run summary --files-report \
  -p "<prompt>" \
  --file "path/**" --file "!**/*.test.*"
```

Run:

```bash
oracle --engine browser --browser-port 55268 \
  --slug "<3-5-words>" \
  -p "<prompt>" \
  --file "path/**" --file "!**/*.test.*"
```

Reattach:

```bash
oracle status --hours 72
oracle session <id> --render
```

## Current Environment

- `oracle` is installed at `/opt/homebrew/bin/oracle`.
- The configured model is `gpt-5.5-pro` in browser mode.
- The dedicated Oracle Chrome profile is `/Users/cypark/.oracle/browser-profile`.
- The current reliable DevTools port is `55268`; omitting it can fail with `ECONNREFUSED` against a random local port.
- Do not use API mode unless the user explicitly approves possible usage costs.

## Guardrails

- Remove low-signal files before sending generated output, logs, or secrets.
- Treat dry-run output as mandatory.
- If a browser run detaches or times out, reattach with `oracle status`/`oracle session`; do not re-run the same prompt.
- Do not use Oracle as a substitute for local verification.
- Do not use Oracle for routine edits, style bikeshedding, or a generic stamp of approval.
