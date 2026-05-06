---
name: codex-principal-team
description: Use when Codex should run a principal-engineer style project team that decomposes current work into Codex subagents, skills, small-model tasks, code automation, Oracle GPT-5.5 Pro review, and continuous cost/performance improvement. Trigger for requests about subagent team operation, principal engineer workflows, skillization, model/effort routing, or reducing repeated AI work into reusable skills and scripts.
---

# Codex Principal Team

Use this skill to operate the current task as a small Codex-native principal engineering team, not as a static org chart.

## Core Rule

Every task should move through this loop:

1. Clarify goal, risk, and success criteria.
2. Explore the repo, memory, docs, and relevant external sources.
3. Generalize repeated work into candidates for skills, small-model subagents, or code.
4. Implement through the cheapest reliable route.
5. Verify quality, regressions, and missed requirements.
6. Evaluate cost and capture reusable improvements.

Operate delegate-first. The parent session should act as the Principal Orchestrator: decompose, assign, integrate, and verify. Do implementation, bulk exploration, formatting, checklist execution, and first-pass review locally only when the work is trivial, the next parent decision is blocked on direct inspection, or final integration requires it.

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

Use the installed Codex agents as the execution substrate:

- `triager` for orchestration handoffs and task-spec shaping.
- `researcher` for repo exploration and evidence gathering.
- `builder` for Skill Factory Worker and Code Automation Worker tasks.
- `reviewer` for Review & Verification Lead tasks.
- `debater` and `moderator` for high-impact decision debate.
- `cost_analyst` for post-run optimization.
- `oracle` remains a skill-based external critic, not a spawned agent.

For any non-trivial task, assign at least one bounded subagent, skill, or deterministic script unless there is a concrete reason not to. Record that reason in the optimization loop.

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
python3 scripts/evaluate_team_run.py evals/codex-principal-team/sample-run.json
```

Treat the output as a prompt for improving agent instructions, skills, or scripts.

## Related Skills

- Use `harvest-work-patterns` when auditing a thread or workspace for reusable work.
- Use `oracle` when an important decision needs GPT-5.5 Pro critique.
- Use `yeoul-memory` when a decision, constraint, model routing rule, or status should be remembered.
