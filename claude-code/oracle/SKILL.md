---
name: oracle-claude-code
description: Use when you need a second-model opinion via the @steipete/oracle CLI for high-risk debugging, non-trivial refactors, architecture or API tradeoff reviews, or decisions that are expensive to reverse. Do not use for routine edits, small bug fixes, or tasks that can be validated quickly in the local codebase.
---

# Oracle (Claude Code)

## Overview

Oracle bundles a prompt and selected files into a one-shot request for another model. Treat Oracle output as advisory and verify it against the codebase and tests.

## When to Use

Use Oracle when:

- the decision has lasting architecture or API impact
- there are multiple viable options with non-obvious tradeoffs
- the change is expensive to reverse
- local tests and code reading alone are unlikely to surface the main risks
- you need a high-risk debugging, refactor, or design review from a second model

Do not use Oracle for:

- routine code edits
- small, local bug fixes
- questions answerable by reading 1-2 files
- broad "review the whole repo" requests

## Quick Reference

- Help:
  - `npx -y @steipete/oracle --help`
- Dry run:
  - `npx -y @steipete/oracle --dry-run summary --files-report -p "<task>" --file "src/**"`
- Browser run:
  - `npx -y @steipete/oracle --engine browser --model gpt-5.4-pro -p "<task>" --file "src/**"`
- Reattach:
  - `oracle status --hours 72`
  - `oracle session <id> --render`

## Implementation

### Decision reviews

At minimum:

- summarize the decision and constraints
- present the leading option and at least one alternative
- ask Oracle to critique the plan, identify risks, and challenge weak assumptions

### File selection

- Pick the fewest files that still contain the truth.
- Run `--dry-run` before any paid or long-running request.
- Inspect the file list and cut low-signal files first.
- Never assume `.gitignore` alone is enough for privacy or relevance.

### Engine choice

- Prefer `--engine browser` explicitly for the normal ChatGPT workflow.
- Use API mode only when you intentionally want API behavior.
- API runs require explicit user consent because they incur usage costs.

### Sessions

- Browser runs can take 10-60 minutes.
- If the run detaches or times out, do not re-run it.
- Reattach to the stored session instead.

## Common Mistakes

- Treating Oracle as a mandatory approval gate
- Re-running detached browser sessions instead of reattaching
- Sending generated files, logs, coverage, snapshots, or vendored code without checking whether they matter
- Attaching secrets or hidden config without reviewing the dry-run output
