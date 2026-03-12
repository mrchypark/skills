---
name: review-loop
description: Use when reviewing a plan or concrete code change that is risky, cross-cutting, or expensive to reverse, and the review should be broken into explicit layers instead of one vague pass.
---

# Review Loop

## Overview

Use this skill to review either a `plan` or `code` target through repeated layer-based critique and revision loops.

Start by declaring the review target and required layers. Then run `layered review -> revise -> fix confirmation review -> full re-review` until no material findings remain.

Prefer this skill for architecture changes, migrations, refactors, security-sensitive changes, performance work, storage changes, and UI changes with complex state.

## 1. Freeze the Review Target

Before the first review pass, declare:

- `target kind`: `plan` or `code`
- `review target`: exact doc, path set, commit range, or diff
- `change context`: one or more of `architecture`, `api`, `storage`, `migration`, `refactor`, `bugfix`, `performance`, `concurrency`, `security`, `ui`, `infra`
- `required layers`: base layers plus any context layers
- `non-goals`: anything explicitly out of scope

If any of these are ambiguous, clarify them before review.

## 2. Always Include the Base Layers

Run these separately. Do not collapse them into one generic pass.

- `intent/scope`
  - Is this solving the right problem?
  - Are scope, non-goals, and acceptance boundaries explicit?

- `correctness/invariants`
  - Are contracts, invariants, and failure modes preserved?
  - Is there any silent regression path?

- `workflow/operability`
  - Do ordering, rollout, recovery, and observability make sense?
  - Are prerequisites and runtime consequences explicit?

- `complexity/YAGNI`
  - Is this the smallest version that proves the goal?
  - Are abstractions, options, or fallback modes premature?

## 3. Add Context Layers Deliberately

Choose extra layers based on the change context. If multiple contexts apply, review the union of their layers.

- `architecture`
  - Add `boundaries/contracts`
- `api`
  - Add `api/compatibility`
- `storage` or `migration`
  - Add `data-integrity/migration-safety`
- `performance` or `concurrency`
  - Add `capacity/contention`
- `security`
  - Add `trust-boundary/security`
- `ui`
  - Add `state/accessibility`
- `infra`
  - Add `deployment/environment`
- `refactor`
  - Add `equivalence/regression-surface`
- `bugfix`
  - Add `reproduction/test-gap`

### Context Layer Meanings

- `boundaries/contracts`
  - Check module boundaries, dependency direction, hidden coupling, and ownership splits.

- `api/compatibility`
  - Check request and response contracts, caller impact, backwards compatibility, and versioning assumptions.

- `data-integrity/migration-safety`
  - Check data loss risk, idempotency, rollback, backfill, and partial-failure handling.

- `capacity/contention`
  - Check hot paths, latency, lock contention, queue growth, and resource ceilings.

- `trust-boundary/security`
  - Check authn, authz, secret handling, trust assumptions, input validation, and privilege changes.

- `state/accessibility`
  - Check state transitions plus loading, error, and empty paths, and verify keyboard and screen-reader behavior.

- `deployment/environment`
  - Check deployment wiring, configuration sources, environment parity, secret and network dependencies, and rollback assumptions.

- `equivalence/regression-surface`
  - Check what behavior must stay unchanged, what deletions are safe, and what callers or side effects are touched.

- `reproduction/test-gap`
  - Check whether the bug was reproduced, whether the fix is targeted, and whether the tests block recurrence.

## 4. Map Defaults by Target Kind

### `plan`

Default layers:

- `intent/scope`
- `correctness/invariants`
- `workflow/operability`
- `complexity/YAGNI`

For plans, focus on problem framing, sequencing, contracts, rollout, and verification claims.

### `code`

Default layers:

- `intent/scope`
- `correctness/invariants`
- `workflow/operability`
- `complexity/YAGNI`

For code, review the exact diff plus the minimal surrounding context, touched tests, and impacted interfaces.

## 5. Prefer Independent Reviewers When Possible

- Use subagents or external reviewers so each layer is evaluated independently.
- Give each reviewer one narrow layer or one tightly scoped bundle.
- Ask for findings first, not rewrites.
- Keep findings severity-ordered and tied to file and line references for code, or section references for plans.

## 6. Revise Before the Next Loop

- Apply material findings directly to the target.
- Tighten scope claims that exceed evidence.
- Add explicit contracts where assumptions were implicit.
- Simplify when reviewers show the design or patch is broader than necessary.
- Do not move on while known material findings remain open.

## 7. Run a Fix Confirmation Review

After revision, re-run the same layers as a targeted check:

- Were the earlier findings actually fixed?
- Did the fix create new issues nearby?
- Is any required layer still materially open?

Do not treat this as the final pass.

## 8. Run a Full Re-Review

Once fix confirmation is clean, run one more whole-target review:

- Re-check the base layers.
- Re-check all required context layers.
- Ask whether the complete artifact still has any material findings.

## 9. Repeat Until Convergence

Run another `revise -> fix confirmation -> full re-review` loop whenever the last full pass still finds material issues.

Stop when:

- fix confirmation reports `no material findings`
- full re-review reports `no material findings`, or
- only explicitly documented residual risks remain

## Output Requirements

At the end, produce:

- the finalized target path or diff range
- the declared `target kind`, `change context`, and `required layers`
- the main changes made during review
- confirmation that both fix confirmation and full re-review were completed
- any intentionally deferred residual risks

## Guardrails

- Do not start reviewing before declaring the target and layers.
- Do not merge all layers into one vague “looks fine” pass.
- Do not review code without naming the change context.
- Do not leave compatibility, migration, security, or regression concerns implicit when the change context requires them.
- Do not treat fix confirmation as equivalent to whole-target approval.
- Do not let scope claims or abstractions exceed the verification evidence.
