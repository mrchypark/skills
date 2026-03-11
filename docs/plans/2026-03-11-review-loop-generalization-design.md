# Review Loop Generalization Design

## Goal

Replace the plan-only `plan-review-loop` skill with a generalized `review-loop` skill that works for both plans and code changes.

## Decisions

- Rename the skill directory and frontmatter name from `plan-review-loop` to `review-loop`.
- Require an explicit declaration of `target kind`, `review target`, `change context`, `required layers`, and `non-goals` before the first review pass.
- Keep the existing convergence shape:
  - layered review
  - revise
  - fix confirmation review
  - full re-review
- Define four base layers for all reviews:
  - `intent/scope`
  - `correctness/invariants`
  - `workflow/operability`
  - `complexity/YAGNI`
- Define context-specific layers for code and risky plans:
  - `boundaries/contracts`
  - `api/compatibility`
  - `data-integrity/migration-safety`
  - `capacity/contention`
  - `trust-boundary/security`
  - `state/accessibility`
  - `deployment/environment`
  - `equivalence/regression-surface`
  - `reproduction/test-gap`

## Rationale

The old skill was strong on plan review but too narrow for reviewing code changes. The new version keeps the useful review loop while making the review frame explicit and repeatable across different change types.

Declaring layers up front prevents vague reviews and makes it clear which risks are intentionally in scope for a given change.

## Out of Scope

- Keeping a compatibility alias under `plan-review-loop`
- Adding installer automation or migration tooling for already installed local copies
