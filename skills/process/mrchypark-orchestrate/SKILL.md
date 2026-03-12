---
name: mrchypark-orchestrate
description: Use when a task is non-trivial and should be executed through agent handoffs, integration, and verification instead of one long local session.
---

# Instructions
- Default to handoff-first. Delegate research, implementation, and review whenever the work can be isolated.
- Keep work local only for trivial one-step edits, direct inspection, or final integration and verification.
- Before dispatching, refresh `.codex/context/ACTIVE_TASK.md` with the objective, constraints, owned files, open questions, and verification target.
- Route decomposition through `triager`, edit-heavy work through `builder`, evidence gathering through `researcher`, and findings through `reviewer`.
- For consequential decisions with real trade-offs, route through `mrchypark-debate` instead of making the call from one agent's perspective.
- Keep each handoff bounded: one owner, one outcome, one verification target.
- After delegated edits return, integrate locally and run `mrchypark-verify` before accepting the result.
