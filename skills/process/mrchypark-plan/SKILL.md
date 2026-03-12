---
name: mrchypark-plan
description: Use when a task is large enough to need concrete execution steps, sequencing, or delegation.
---

# Instructions
- Break the work into the smallest useful vertical slices that produce working outcomes.
- For each slice, state the goal, the owned files or systems, the dependency order, and the verification that proves it is done.
- Call out which tasks can be delegated in parallel and which tasks are on the critical path and should stay local.
- Refresh `.codex/context/ACTIVE_TASK.md` with the currently active slice before dispatching the first implementation handoff.
- Include rollback or cleanup steps only when failure would leave behind state, schema drift, or generated artifacts.
- Keep the plan short and executable. Avoid status theater, placeholder tasks, or approvals that do not change the next action.
- Persist the plan to `docs/plans/YYYY-MM-DD-<topic>-plan.md` only when the work is large enough to need a durable artifact across sessions or collaborators.
