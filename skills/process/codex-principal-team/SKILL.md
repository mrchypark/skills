---
name: codex-principal-team
description: Use when Codex should run a principal-engineer style project team that decomposes current work into Codex subagents, skills, small-model tasks, code automation, Oracle GPT-5.5 Pro review, and continuous cost/performance improvement. Trigger for requests about subagent team operation, principal engineer workflows, skillization, model/effort routing, or reducing repeated AI work into reusable skills and scripts.
---

# Codex Principal Team

Use this skill to operate the current task as a small Codex-native principal engineering team, not as a static org chart.

Treat this skill as the default operating mode for user requests that involve code, repository work, planning, review, debugging, research, automation, or any multi-step task. Enter this mode even when the user does not name the skill. If the user invokes or asks for `codex-principal-team`, treat that as an explicit delegation and subagent request for non-trivial work under the `spawn_agent` policy. Opt out only when the user explicitly asks for direct/local-only work, asks for no subagents, wants a simple answer, the task is genuinely trivial, subagents are unavailable, or a named blocker requires immediate local inspection.

## Core Rule

Every task should move through this loop:

1. Clarify goal, risk, and success criteria.
2. Explore the repo, memory, docs, and relevant external sources.
3. Generalize repeated work into candidates for skills, small-model subagents, or code.
4. Implement through the cheapest reliable route.
5. Verify quality, regressions, and missed requirements.
6. Evaluate cost and capture reusable improvements.

Operate delegate-first. The parent session is the Principal Orchestrator: decompose work, assign bounded tasks, track progress, integrate outputs, resolve conflicts, make final decisions, and perform final verification. Do not perform implementation, bulk exploration, formatting, checklist execution, or first-pass review locally when a subagent, skill, or deterministic script can own that work.

Keep parent-only work limited to orchestration, integration, conflict resolution, final decisions, and final verification. A mini parent session may act as an orchestrator, but a delegated subagent must not recursively fan out unless the user explicitly authorized nested delegation and the runtime depth policy permits it. Use direct parent execution only for trivial changes, unavailable subagent tooling, explicit user opt-out, or a named blocker that requires immediate local inspection.

## Delegation Gate

Before non-trivial work, state the delegation plan in the working plan or update:

- Exploration owner: runtime `explorer`, toolkit `researcher` when directly callable, a domain skill, or a deterministic script.
- Implementation owner: runtime `worker`, toolkit `builder` when directly callable, a domain skill, or a deterministic script.
- Review owner: toolkit `reviewer` when directly callable, `review-loop`, `review-workflow`, Oracle, or another bounded review path.
- Verification owner: the parent session for final verification, optionally preceded by delegated checks.
- Parent-only work: integration, conflict resolution, final decisions, final verification, or a named blocker.
- Direct edit budget: parent should not perform more than one non-trivial `apply_patch` before handing implementation to runtime `worker` or directly callable toolkit `builder` unless a policy exception applies.
- Policy exception: if subagents are unavailable or the current tool policy does not permit spawning them, say so and use the best bounded skill or deterministic-script substitute.
- Recursion rule: delegated subagents do their assigned task directly; they do not spawn additional subagents unless explicitly authorized and runtime depth permits it.

## Team Routing

Read [references/team-roster.md](references/team-roster.md) when assigning roles or choosing models.

Default operating-role routing:

- Use `gpt-5.5` `high` for Principal Orchestrator decisions.
- Use `gpt-5.4-mini` `medium` for repo exploration and cost analysis.
- Use `gpt-5.4` `medium` for generalization, comparison, and evaluation.
- Use `gpt-5.5` `medium` for task specs and complex tradeoffs.
- Use `gpt-5.3-codex` `high` for skill, script, and implementation work.
- Use `gpt-5.3-codex-spark` `low` for cheap deterministic searches, checklists, and formatting.
- Use the `oracle` skill as Oracle Critic with ChatGPT `GPT-5.5 Pro` `standard`; use `extended` only for migration, security, data-loss, or expensive-to-reverse decisions.

Do not conflate runtime callable subagents with installed toolkit agents. In the current active spawn surface, the callable runtime roles are `explorer` and `worker`; toolkit agents include `triager`, `builder`, `researcher`, `reviewer`, `cost_analyst`, `debater`, and `moderator`. Use the roster mapping to translate operating roles onto whatever the runtime actually exposes.

For any non-trivial task, assign at least one bounded subagent, skill, or deterministic script unless there is a concrete reason not to. When `codex-principal-team` is explicitly invoked and `spawn_agent` is available, use at least one runtime subagent unless an opt-out, trivial-task, unavailable-tooling, tool-policy, or named-blocker exception applies. Record any exception in the optimization loop.

## Execution Workflow

Read [references/execution-flow.md](references/execution-flow.md) before running a multi-step task.

Mandatory stages:

1. Intake
2. Exploration
3. Generalization
4. Decision review
5. Implementation
6. Verification
7. Optimization loop

Do not skip the optimization loop. If no skill, subagent, or script was used for a material activity, name the activity and decide whether it should be generalized.

## Evaluation

For substantial runs, create or update a run log using the schema in [references/evaluation.md](references/evaluation.md).

Use the deterministic evaluator:

```bash
python3 skills/process/codex-principal-team/scripts/evaluate_team_run.py evals/codex-principal-team/sample-run.json
```

From the repository root, `python3 scripts/evaluate_team_run.py ...` is kept as a compatibility wrapper.

For session-log audits, use:

```bash
python3 skills/process/codex-principal-team/scripts/analyze_codex_sessions.py "$HOME"/.codex/archived_sessions/rollout-2026-05-07*.jsonl
```

Treat the output as a prompt for improving agent instructions, skills, or scripts.

## Related Skills

- Use `harvest-work-patterns` when auditing a thread or workspace for reusable work.
- Use `oracle` when an important decision needs GPT-5.5 Pro critique.
- Use `yeoul-memory` when a decision, constraint, model routing rule, or status should be remembered.
