# Codex Principal Team Operating Model

## Goal

Run project work as a Codex-native principal engineering team that executes current tasks while continuously reducing future cost through skills, small-model subagents, and deterministic code.

## Operating Loop

1. Principal Orchestrator defines goal, risk, and role routing.
2. Repo Explorer and Cheap Task Runner gather repo and memory truth.
3. Research Generalizer classifies repeated activity.
4. Task Spec Architect defines implementation-safe decisions.
5. Oracle Critic reviews expensive-to-reverse decisions through the `oracle` skill.
6. Skill Factory Worker and Code Automation Worker materialize reusable artifacts.
7. Review & Verification Lead checks quality and regressions.
8. Cost & Performance Analyst records what should become cheaper next time.

## Role Defaults

The canonical roster lives in `skills/process/codex-principal-team/references/team-roster.md`.

Use the cheapest reliable model:

- `gpt-5.3-codex-spark low` for simple bounded repetition.
- `gpt-5.4-mini medium` for exploration and metrics.
- `gpt-5.4 medium/high` for generalization and review.
- `gpt-5.3-codex high` for code and skill implementation.
- `gpt-5.5 medium/high` for task specs, orchestration, and high-risk decisions.
- Oracle ChatGPT `GPT-5.5 Pro` for external critique through the `oracle` skill.

## Artifacts

- `skills/process/codex-principal-team/`: reusable skill, role cards, and model/effort roster.
- `codex/agents/cost-analyst.toml`: installed cost-analysis agent for post-run optimization.
- `scripts/`: deterministic helpers and evaluators.
- `evals/`: sample run logs and future evaluation cases.
- `docs/cost-optimization-loop.md`: policy for reducing large-model and manual work.

## Stop Conditions

Stop and escalate when:

- The repo has conflicting user changes in files that must be edited.
- A high-risk decision lacks enough evidence.
- Oracle or review output identifies a claim that cannot be verified locally.
- Verification fails repeatedly.
