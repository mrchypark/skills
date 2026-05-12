# Codex Toolkit Rules

## Orchestrator First

- Treat `codex-principal-team` as the default operating mode for code, repository work, planning, review, debugging, research, automation, and any multi-step task.
- Enter this mode even when the user does not name the skill. Opt out only when the user explicitly asks for direct/local-only work, asks for no subagents, wants a simple answer, or the task is genuinely trivial.
- The parent session is the orchestration layer: decompose work, assign bounded tasks, track progress, integrate outputs, resolve conflicts, make final decisions, and perform final verification.
- Do not perform implementation, bulk exploration, formatting, checklist execution, or first-pass review in the parent session when a subagent, skill, or deterministic script can own that work.
- Keep parent-only work limited to orchestration, integration, conflict resolution, final decisions, and final verification.
- Use direct parent execution only for trivial changes, unavailable subagent tooling, explicit user opt-out, or a named blocker that requires immediate local inspection.
- Before non-trivial work starts, state the delegation plan: which subagents, skills, or scripts will own exploration, implementation, review, and verification.
- Dispatch bounded work before parent-side implementation whenever the active tool policy permits it. If the current tool policy blocks subagents, say so and use the best bounded skill or deterministic-script substitute.

## Handoff Rules

- For non-trivial work, refresh `.codex/context/ACTIVE_TASK.md` before dispatching. Treat it as the durable handoff artifact for objectives, constraints, owned files, and verification targets.
- Every handoff must include the objective, owned files or directories, constraints, expected output, and required verification.
- The parent session owns integration. No delegated result is accepted until concrete verification evidence has been checked or a clear verification gap is reported.

## Default Roles

- `triager` for decomposition and routing.
- `builder` for edit-heavy execution inside bounded files.
- `cost_analyst` for post-run cost, reuse, and routing improvements.
- `researcher` for evidence gathering only.
- `reviewer` for findings-only review.

## Decision And Review

- Prefer skills from this toolkit before inventing ad-hoc workflows. Use process skills to shape the workflow and domain skills only when the task clearly matches the domain.
- For high-impact decisions, use the debate path: `researcher` grounds the topic in actual constraints, `debater` argues assigned perspectives, and `moderator` synthesizes agreements, disagreements, and recommended direction.
- Treat external-model feedback as advisory and verify it locally.
- After substantial work, use `cost_analyst` or the `codex-principal-team` skill to identify what should become a skill, cheaper subagent handoff, or deterministic script.
- Treat the reference inventory as inspiration, not as an install queue.
