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

## Runtime And Toolkit Mapping

The ten permanent roles are an operating model, not ten guaranteed callable Codex agents. Keep these layers separate:

- Runtime callable subagents are the names accepted by the active `spawn_agent` surface. The current active surface exposes `explorer` and `worker`.
- Toolkit installed agents are installed under the toolkit and may be available in project templates or other runtimes: `triager`, `builder`, `researcher`, `reviewer`, `cost_analyst`, `debater`, and `moderator`.
- Skill-based or external routes, such as `oracle`, `review-loop`, `review-workflow`, and deterministic scripts, are delegation substitutes but are not spawned runtime agents.

When assigning work, choose the operating role first, then map it onto the active runtime or the installed toolkit role that is actually callable:

| Operating Role | Preferred Runtime / Toolkit Route |
| --- | --- |
| Principal Orchestrator | parent session |
| Repo Explorer | `explorer` |
| Research Generalizer | `explorer` for evidence, parent session for synthesis |
| Task Spec Architect | parent session; use Oracle for expensive-to-reverse critique |
| Skill Factory Worker | `worker`; `builder` only when the toolkit agent is directly callable |
| Code Automation Worker | `worker`; `builder` only when the toolkit agent is directly callable |
| Cheap Task Runner | `explorer` or deterministic script |
| Review & Verification Lead | `explorer` with a findings-only review prompt; `reviewer` only when directly callable |
| Cost & Performance Analyst | session-log analyzer plus `harvest-work-patterns`; `cost_analyst` only when callable |
| Debate roles | `researcher`, `debater`, and `moderator` only when directly callable; otherwise use the debate workflow in the parent session or Oracle for high-impact critique |
| Oracle Critic | `oracle` skill, not a spawned runtime agent |

When the active tool policy permits model overrides, set `model` and `reasoning_effort` from the roster. When policy requires inherited models, put the intended role, model, and effort in the handoff prompt and record that execution used inherited defaults.

Invoking or asking for `codex-principal-team` counts as an explicit delegation and subagent request for non-trivial work under the `spawn_agent` policy. The exceptions are explicit opt-out, genuinely trivial work, unavailable subagent tooling, current tool-policy blocks, or a named blocker that requires immediate local inspection.

A mini parent session can act as an orchestrator for its assigned scope. A delegated subagent should not recursively fan out to more subagents unless the handoff explicitly authorizes nested delegation and the runtime depth policy permits it.

## Routing Rules

- Prefer the cheapest role that can reliably produce the required artifact.
- Escalate when uncertainty is high, evidence conflicts, or reversal cost is high.
- De-escalate repeated work into a skill, small-model role, or script after one successful manual pass.
- Keep permanent roles under ten; add temporary mission roles only for a bounded project phase.
- Treat user-requested subagent use as a separate signal from skill-driven delegation. Record it in the run log.
- Parent session may perform at most one non-trivial implementation patch before handing implementation to `worker`, unless the patch is final integration or conflict resolution.
- If the current runtime exposes only `explorer` and `worker`, do not name toolkit roles as spawned agents. Put the desired toolkit role in the handoff context and spawn the closest runtime role.

## Subagent Invocation Template

Use this when delegating:

```text
Role:
Model / effort:
Callable agent type:
Context:
Owned files or scope:
Task:
Output contract:
Do not:
Verification:
```

Workers are not alone in the codebase. They must not revert unrelated edits and must adapt to existing user changes.
Unless explicitly authorized, handoffs should also say: "Do not spawn additional subagents; complete this bounded task directly and report any blocker back to the parent."
