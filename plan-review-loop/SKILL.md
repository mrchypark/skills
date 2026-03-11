---
name: plan-review-loop
description: Review implementation plans, architecture docs, and design proposals through repeated multi-angle critique and revision loops. Use when Codex needs to pressure-test a plan before implementation, especially to validate scope and what/why, workflow causality and ordering, correctness hazards, and overengineering or YAGNI risk. This skill is for workflows that require an initial review, a revision pass, a re-review of the applied fixes, and then a final whole-plan review confirming the complete plan is acceptable.
---

# Plan Review Loop

## Overview

Use this skill to turn a rough or risky plan into an implementation-ready plan by running repeated review loops from independent perspectives and revising between loops.

Prefer this skill before major refactors, backend redesigns, migrations, performance work, storage/replication changes, or any plan that would be expensive to reverse later.

## Workflow

### 1. Load the plan and freeze the review target

- Read the current plan document or proposal.
- Restate the intended deliverable in one or two lines.
- Identify the claimed scope, non-goals, success criteria, and verification plan.
- If the plan is still ambiguous, clarify that first before starting review loops.

### 2. Review from three required angles

Run these review angles separately. Keep findings ordered by severity and tied to exact file references when possible.

- `what/why review`
  - Check whether the plan solves the right problem.
  - Check whether scope matches the stated goal.
  - Look for missing product boundaries, hidden requirements, and vague contracts.

- `workflow/causality review`
  - Check publish, restore, recovery, migration, or rollout ordering.
  - Look for steps that happen in the wrong order, missing preconditions, and correctness hazards.
  - Look for task sequencing that will force rework later.

- `overengineering/YAGNI review`
  - Check whether the first useful version is too broad.
  - Look for speculative abstractions, premature optimization, and optional complexity on the critical path.
  - Push the plan toward a smaller reference implementation first.

### 3. Prefer independent reviewers when available

- Use subagents or external models when available so each angle is reviewed independently.
- Give each reviewer a narrow prompt and ask for findings only.
- If external reviewers disagree, bias toward the smaller and safer plan unless the broader version is clearly required.

### 4. Revise the plan before the next loop

- Apply material findings directly to the plan document.
- Tighten scope when a reviewer shows the plan is claiming more than it proves.
- Add explicit contracts when a reviewer identifies hidden assumptions.
- Reorder tasks when a reviewer shows the workflow has causal gaps.
- Do not move on while known material issues remain open.

### 5. Run a 수정 확인 리뷰

After applying findings, do not jump straight to completion.

- Re-run the same review angles against the revised plan.
- Ask reviewers to check whether the specific earlier findings were actually fixed.
- Treat this as a targeted fix-confirmation pass, not a fresh open-ended review.
- If a reviewer says a fix is incomplete or introduced a new issue, revise again before proceeding.

### 6. Run 다시 전체 리뷰

Once the 수정 확인 리뷰 is clean, run one more full review of the entire plan.

- This pass is broader than fix verification.
- Its purpose is to confirm the final document still works as a whole after all revisions.
- Use the same core angles again, or a condensed final pass, but explicitly ask whether the complete plan now has any remaining material findings.
- Do not skip this step just because the fix-verification pass was green.

### 7. Repeat until convergence

Run another `전체 리뷰 -> 수정 확인 리뷰 -> 다시 전체 리뷰` cycle after meaningful revisions whenever the last whole-plan review still finds material issues.

Stop when:
- the 수정 확인 리뷰 reports `no material findings`
- the 다시 전체 리뷰 also reports `no material findings`, or
- only residual execution risks remain and they are documented explicitly.

## Output Requirements

At the end of the loop, produce:

- the finalized plan path
- a short summary of the main changes made during review
- confirmation that both the 수정 확인 리뷰 and 다시 전체 리뷰 were completed
- any residual risks that remain intentionally deferred

## Guardrails

- Do not treat “good direction” as approval if reviewers still found material gaps.
- Do not merge multiple review angles into one vague pass.
- Do not leave scope claims broader than the verification plan can support.
- Do not let optimization layers land before the reference path is proven unless the optimization is part of correctness.
- Do not let fallback behavior or compatibility modes creep back in unless the plan explicitly justifies them.
- Do not treat “the fixes look good” as equivalent to 다시 전체 리뷰 approval.
- Do not skip the explicit 수정 확인 리뷰 after applying changes.
