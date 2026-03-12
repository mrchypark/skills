# Context Fragments

Use `.codex/context/ACTIVE_TASK.md` as the durable handoff artifact for non-trivial work.

Keep it short and update it before dispatching agents. Include:

- objective
- constraints
- owned files or directories
- open questions
- verification target
- expected return payload

For structured debates, keep the question and hard constraints in `ACTIVE_TASK.md`. Store raw participant outputs in `.codex/context/DEBATE_LOG.md` only when the debate needs to survive a later handoff or asynchronous review. Move only the synthesized result or chosen direction back into `ACTIVE_TASK.md`.
