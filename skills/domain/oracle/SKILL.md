---
name: oracle
description: Use when an important technical or product decision needs an external critique through the Oracle CLI before you finalize the direction.
---

# Oracle

## Overview

Use `@steipete/oracle` as a second-opinion path for decisions that are expensive to reverse. Oracle output is advisory. Verify it against the codebase, local tests, and project constraints before adopting it.

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
5. Reattach to detached browser sessions instead of re-running them.
6. Summarize the critique in your own words and decide what to verify locally before changing direction.

## Quick Reference

- Help:
  - `npx -y @steipete/oracle --help`
- Dry run:
  - `npx -y @steipete/oracle --dry-run summary --files-report -p "<prompt>" --file "path/**"`
- Browser review example:
  - `npx -y @steipete/oracle --engine browser -p "<prompt>" --file "path/**"`
- Session reattach:
  - `oracle status --hours 72`
  - `oracle session <id> --render`

## Guardrails

- Remove low-signal files before sending generated output, logs, or secrets.
- Treat dry-run output as mandatory.
- Do not use Oracle as a substitute for local verification.
- Do not use Oracle for routine edits, style bikeshedding, or a generic stamp of approval.
