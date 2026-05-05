# Codex Principal Team Roster

## Permanent Roles

| Role | Model | Effort | Use For | Avoid For |
| --- | --- | --- | --- | --- |
| Principal Orchestrator | `gpt-5.5` | `high` | Goal decomposition, risk routing, final decisions, integration | Bulk search, formatting, routine edits |
| Repo Explorer | `gpt-5.4-mini` | `medium` | Repo mapping, AGENTS/README/skill/git/Yeoul inspection | Architecture decisions |
| Research Generalizer | `gpt-5.4` | `medium` | Turning findings into skill, subagent, script, or code candidates | Direct implementation |
| Task Spec Architect | `gpt-5.5` | `medium` | Interfaces, success criteria, failure modes, tradeoffs | Repeated mechanical checks |
| Skill Factory Worker | `gpt-5.3-codex` | `high` | `SKILL.md`, references, templates, validation resources | Product direction |
| Code Automation Worker | `gpt-5.3-codex` | `high` | Scripts, deterministic evaluators, code generators, CI helpers | Open-ended product strategy |
| Cheap Task Runner | `gpt-5.3-codex-spark` | `low` | Lists, grep-style scans, checklist execution, format conversion | Ambiguous judgment |
| Review & Verification Lead | `gpt-5.4` | `high` | Tests, review, regression risk, missing requirements | Writing broad new features |
| Cost & Performance Analyst | `gpt-5.4-mini` | `medium` | Token/time/failure tracking and cheaper routing proposals | Final architectural calls |
| Oracle Critic | `oracle` skill, ChatGPT `GPT-5.5 Pro` | `standard`, or `extended` for high-risk cases | External critique for expensive-to-reverse decisions | Routine edits, small bugs, style preferences |

The same routing is stored in `references/roster.json` for deterministic validation and future automation.

## Installed Agent Mapping

The ten permanent roles are an operating model, not ten installed Codex agents. Use the installed toolkit agents this way:

| Operating Role | Installed Agent |
| --- | --- |
| Principal Orchestrator | parent session plus `triager` |
| Repo Explorer | `researcher` |
| Research Generalizer | `researcher`; escalate synthesis to parent session |
| Task Spec Architect | `triager`, with `debater` and `moderator` for high-impact tradeoffs |
| Skill Factory Worker | `builder` |
| Code Automation Worker | `builder` |
| Cheap Task Runner | `researcher` or built-in explorer-style delegation |
| Review & Verification Lead | `reviewer` |
| Cost & Performance Analyst | `cost_analyst` |
| Oracle Critic | `oracle` skill, not a spawned agent |

## Routing Rules

- Prefer the cheapest role that can reliably produce the required artifact.
- Escalate when uncertainty is high, evidence conflicts, or reversal cost is high.
- De-escalate repeated work into a skill, small-model role, or script after one successful manual pass.
- Keep permanent roles under ten; add temporary mission roles only for a bounded project phase.

## Subagent Invocation Template

Use this when delegating:

```text
Role:
Model / effort:
Context:
Owned files or scope:
Task:
Output contract:
Do not:
Verification:
```

Workers are not alone in the codebase. They must not revert unrelated edits and must adapt to existing user changes.
