# Codex Toolkit Rules

## Orchestrator First

- Treat `codex-principal-team` as the default operating mode for code, repository work, planning, review, debugging, research, automation, and any multi-step task.
- Enter this mode even when the user does not name the skill. If the user invokes or asks for `codex-principal-team`, treat that as an explicit delegation and subagent request for non-trivial work under the `spawn_agent` policy. Opt out only when the user explicitly asks for direct/local-only work, asks for no subagents, wants a simple answer, the task is genuinely trivial, subagents are unavailable, or a named blocker requires immediate local inspection.
- The parent session is the orchestration layer: decompose work, assign bounded tasks, track progress, integrate outputs, resolve conflicts, make final decisions, and perform final verification.
- Do not perform implementation, bulk exploration, formatting, checklist execution, or first-pass review in the parent session when a subagent, skill, or deterministic script can own that work.
- Keep parent-only work limited to orchestration, integration, conflict resolution, final decisions, and final verification.
- A mini parent session can act as orchestrator for its assigned scope, but delegated subagents must not recursively fan out unless explicitly authorized and runtime depth permits it.
- Use direct parent execution only for trivial changes, unavailable subagent tooling, explicit user opt-out, or a named blocker that requires immediate local inspection.
- Before non-trivial work starts, state the delegation plan: which subagents, skills, or scripts will own exploration, implementation, review, and verification.
- Dispatch bounded work before parent-side implementation whenever the active tool policy permits it. If the current tool policy blocks subagents, say so and use the best bounded skill or deterministic-script substitute.

## Handoff Rules

- For non-trivial work, refresh `.codex/context/ACTIVE_TASK.md` before dispatching. Treat it as the durable handoff artifact for objectives, constraints, owned files, and verification targets.
- Every handoff must include the objective, owned files or directories, constraints, expected output, and required verification.
- The parent session owns integration. No delegated result is accepted until concrete verification evidence has been checked or a clear verification gap is reported.

## Runtime And Toolkit Roles

- Runtime callable subagents depend on the active `spawn_agent` surface. When the surface exposes only `explorer` and `worker`, use `explorer` for evidence gathering and independent findings-only review, and `worker` for bounded edit-heavy execution.
- Toolkit installed agents are distinct from runtime callable roles: `triager`, `builder`, `researcher`, `reviewer`, `cost_analyst`, `debater`, and `moderator`.
- Use `triager` for decomposition and routing, `builder` for bounded edits, `researcher` for evidence, `reviewer` for findings-only review, and `cost_analyst` for post-run cost/reuse/routing improvements only when those toolkit agents are directly callable. Otherwise map them through `explorer`, `worker`, skills, or deterministic scripts.

## Decision And Review

- Prefer skills from this toolkit before inventing ad-hoc workflows. Use process skills to shape the workflow and domain skills only when the task clearly matches the domain.
- For high-impact decisions, use the debate path only when `researcher`, `debater`, and `moderator` are directly callable. Otherwise, gather evidence through the active runtime roles or deterministic scripts, then synthesize in the parent session or use Oracle for expensive-to-reverse critique.
- Treat external-model feedback as advisory and verify it locally.
- After substantial work, use `cost_analyst` or the `codex-principal-team` skill to identify what should become a skill, cheaper subagent handoff, or deterministic script.
- Treat the reference inventory as inspiration, not as an install queue.
