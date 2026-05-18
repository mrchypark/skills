---
name: remote-review-preflight
description: Use when preparing to request Gemini Code Assist, `/gemini review`, GitHub bot review, CLI review, or another remote reviewer, especially when the goal is a clean first pass with no actionable feedback.
---

# Remote Review Preflight

## Overview

Use this skill before asking a remote or CLI reviewer to inspect a change. The goal is to make the first review request boring: the reviewer should have no actionable feedback because local review already found and fixed the likely issues.

This is a gate, not a summary step. Do not request remote review until the gate is passed or the user explicitly accepts the remaining risk.

## Inputs

Collect:

- exact diff, commit range, branch, or PR scope
- intended reviewer, such as Gemini Code Assist, `/gemini review`, `gemini` CLI, Qwen, Oracle, or another bot
- repository instructions and required local checks
- prior review corpus for this repository, component, or nearest comparable change
- user-stated success target, especially "first remote review returns no feedback"

## 1. Mine Prior Remote Review Failures

Search durable memory and local/remote history before reviewing the new change.

Prefer, in order:

- Yeoul search for the repository, reviewer, PR number, feature area, and repeated failure words
- bundled common review-pattern packs for the active language, such as `references/patterns/common-go.json`
- repo-specific review-pattern facts stored in Yeoul, not files committed to the product repository
- thread-aware PR review state from prior PRs when available
- follow-up commits made after remote review comments
- local review notes, issue comments, and merge summaries

Treat every follow-up fix after an initial remote review request as a missed preflight check. Extract the failure mode, not just the literal file.

For example, prior cached Go review loops produced reusable failure modes:

- documented defaults did not match portable platform conventions
- hash keys omitted build-affecting state such as workspace, build package, hidden files, or embedded assets
- source discovery pruned too much, included too much, or missed root-level files
- fallback commands were assumed instead of tested across `shasum`, `sha256sum`, `readlink`, `realpath`, and PATH invocation
- temporary files and interrupted builds left stale state
- vendored or generated dependency trees polluted cache inputs
- docs, examples, and launcher behavior drifted apart
- validation proved repository health but not the reviewer-risk scenarios

Use these as seed examples only. Add project-specific findings from the current history.

## Pattern Storage Levels

Keep review-preflight knowledge out of product repositories unless the repository
itself is the skill or tooling project.

- **Common language/project patterns** live in this skill under
  `references/patterns/`. Load the smallest relevant file, for example
  `references/patterns/common-go.json` for Go work.
- **Repository-specific patterns** live in Yeoul. Search for queries like
  `review pattern <repo>`, `remote review <repo>`, and the feature area before
  requesting review. Record new repo-specific patterns in Yeoul after the loop.
- **Product repository files** should only contain product code, tests, docs, and
  repo-owned contributor instructions. Do not add Codex review-policy files or
  generated review-pattern corpora to an application/library repo just to improve
  future Codex behavior.

If a pattern proves useful across more than one repository, promote it from a
Yeoul repo-specific note into a common pattern file in this skill. If it depends
on local domain invariants, keep it in Yeoul.

## 2. Build a Reviewer-Risk Ledger

Create a short ledger before editing:

```text
Risk | Why reviewer may flag it | Local evidence | Action | Status
```

At minimum, consider:

- scope and intent: the change solves the stated problem without unrelated expansion
- contract consistency: docs, examples, scripts, tests, and implementation agree
- portability: platform, shell, path, line ending, locale, and tool fallback assumptions
- invocation modes: direct path, symlink, PATH, worktree, CI, temp directory, and missing optional tools
- state invalidation: cache keys, config, generated files, workspaces, dependencies, and build flags
- discovery and filtering: hidden files, hidden directories, vendor, generated files, embeds, and root paths
- cleanup and failure handling: signals, partial writes, retries, idempotency, stale temp files, and rollback
- trust boundary: untrusted input, secrets, remote text, command construction, and broad file access
- verification evidence: commands prove the risky behavior, not only the happy path

Each ledger row must end as `fixed`, `verified not applicable`, or `accepted residual risk`.

## 3. Perform Local Reviewer Simulation

Review as if you are the remote reviewer trying to find the first actionable comment.

Run these passes separately:

1. Diff contract pass: compare every changed doc, example, script, and test against the same behavioral contract.
2. Edge-case pass: exercise the ledger's portability, invocation, state, discovery, cleanup, and trust-boundary assumptions.
3. Regression pass: inspect nearby old behavior and previous reviewer failure modes for recurrence.
4. Minimality pass: remove unnecessary options, abstractions, or broad wording that invites review comments.
5. Evidence pass: ensure every non-obvious claim has a command, test, local reproduction, or explicit rationale.

Fix material findings immediately. Re-run the relevant pass after each fix.

## 4. Run Scenario Checks

Repository smoke tests are necessary but not sufficient. Add targeted checks for reviewer-risk assumptions.

Useful checks include:

- syntax or parser checks for changed snippets
- command simulations in clean temp directories
- alternate invocation paths, including symlink and PATH execution when relevant
- missing optional file or missing optional tool behavior
- hidden, vendor, generated, embedded, empty, and unusually named input paths
- interrupted command or partial-output cleanup when the code writes temporary state
- before/after comparisons for refactors and documentation-only claims

If a risk cannot be executed cheaply, state why and inspect the smallest local evidence that still tests the assumption.

## 5. Prepare the Review Request

Only after all material preflight findings are closed, prepare a compact evidence packet:

- change summary
- prior reviewer failure modes considered
- local issues found and fixed during preflight
- commands and scenario checks run
- residual risks, if any
- exact reason the remote reviewer is expected to return no actionable feedback

Then request the remote or CLI review using the provider-specific workflow.

## Stop Rules

Proceed to remote review only when:

- every ledger row is `fixed` or `verified not applicable`
- validation covers both repository health and reviewer-risk scenarios
- docs and implementation agree
- residual risks are explicit and accepted by the user

If any material row remains open, do not request remote review. Report the open row and the next local action instead.
