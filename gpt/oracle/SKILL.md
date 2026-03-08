---
name: oracle-gpt
description: Comprehensive Oracle CLI skill for GPT-oriented workflows. Use when you want a second-model review via @steipete/oracle for high-risk debugging, non-trivial refactors, architecture or API tradeoff reviews, or decisions that are expensive to reverse, and when bundling a prompt plus a tightly scoped file set for browser or API review will improve the quality of feedback.
---

# Oracle (GPT)

## Overview

Use Oracle to package a prompt and a focused set of files into a single review request for another model. Treat Oracle output as advisory and verify conclusions against the codebase, tests, and project constraints.

## Core Capabilities

### 1. Decision reviews

Use Oracle to critique meaningful technical or product choices when:

- the decision has lasting architecture or API impact
- there are multiple viable options with non-obvious tradeoffs
- the change is expensive to reverse
- local tests and code reading alone are unlikely to surface the main risks

When asking for a decision review:

- summarize the decision and constraints
- present the leading option and at least one alternative
- ask Oracle to critique the plan, identify risks, and challenge weak assumptions

### 2. Change and debugging reviews

Use Oracle for:

- high-risk debugging with unclear root cause
- non-trivial refactors or migrations
- design checks and cross-validation on important changes

Do not use Oracle for routine edits, small bug fixes, or questions you can answer quickly by reading one or two files or running the tests locally.

### 3. Session-based browser reviews

Prefer browser mode for the normal ChatGPT workflow:

- `--engine browser`
- `--model gpt-5.4-pro`

Browser runs can take 10-60 minutes. If a run detaches or times out, reattach to the stored session instead of re-running it.

## Recommended Workflow

1. Narrow the file set to the smallest useful scope.
2. Run `--dry-run` and inspect the attached file list.
3. Check for token-heavy or low-signal files before sending.
4. Run Oracle in browser mode unless you explicitly want API behavior.
5. Reattach to the stored session if the browser run is interrupted.

## Quick Reference

- Help:
  - `npx -y @steipete/oracle --help`
- Dry run:
  - `npx -y @steipete/oracle --dry-run summary --files-report -p "<task>" --file "src/**"`
- Browser review:
  - `npx -y @steipete/oracle --engine browser --model gpt-5.4-pro -p "<task>" --file "src/**"`
- Session reattach:
  - `oracle status --hours 72`
  - `oracle session <id> --render`

## Risk Controls

- Always inspect the dry-run output before sending.
- Exclude low-signal files first: snapshots, coverage, build output, logs, generated files, and vendor copies unless they are central to the question.
- Do not assume `.gitignore` alone is enough to protect relevance or privacy.
- Use `--engine browser` explicitly when cost, provider, or session behavior matters.
- API runs require explicit user consent because they incur usage costs.
- Treat ~196k tokens as a soft operating target, not a goal.

## Common Mistakes

- Sending broad repo slices instead of a tight file set
- Re-running a detached browser session instead of reattaching
- Using Oracle as a mandatory approval gate instead of a second opinion
- Attaching secrets or hidden config without checking the dry-run output
