---
name: mrchypark-brainstorm
description: Use when a new task or change needs clarification and a shared design before implementation begins.
---

# Instructions
- Use this only when the request is ambiguous, the behavior change is non-trivial, or there is a real design fork.
- Read the request plus the smallest relevant set of files to surface assumptions, constraints, success metrics, and the parts that are still unknown.
- Ask only the questions that block a defensible implementation. Do not force a long interview when a reasonable assumption is cheap to reverse.
- Propose two to three concrete approaches, call out the main trade-offs, and lead with the recommendation you would implement.
- Keep the output executable: scope, affected components, data flow, risks, and how the result will be verified.
- For non-trivial work, capture the chosen direction in `.codex/context/ACTIVE_TASK.md` so downstream agents inherit the same intent.
- Persist a short design note to `docs/specs/YYYY-MM-DD-<topic>-design.md` only when the decision needs to survive a later handoff or a multi-session effort. Otherwise keep the design inline.
- Once the direction is chosen, hand off to `mrchypark-plan` or `mrchypark-orchestrate` instead of jumping straight into a long local implementation turn.
