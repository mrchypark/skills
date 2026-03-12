---
name: mrchypark-delegate
description: Use when handing a Codex job or subtask to another agent or teammate with clear scope.
---

# Instructions
- Delegate by default whenever the work can be isolated without blocking the immediate next local step.
- State the objective, owned files or modules, explicit constraints, and the acceptance criteria, including required verification.
- Prefer pointing the delegatee at `.codex/context/ACTIVE_TASK.md` plus a short task-specific delta instead of rewriting the whole brief from scratch.
- Pass only the context the delegatee needs. Do not dump the whole repository state or ask another agent to rediscover the task from scratch.
- Tell the delegatee whether they are gathering evidence, reviewing, or editing code. Do not mix all three roles in one handoff unless the task is truly tiny.
- Require a concise return payload: what changed, what did not, what was verified, and any blockers or assumptions that still need resolution.
- Do not create recursive delegation chains by default. The coordinator should remain responsible for integration.
