# Evaluation Reference

## Run Log Schema

Use this shape for each substantial task:

```json
{
  "task": "short task name",
  "large_model_actions": 0,
  "small_model_actions": 0,
  "oracle_calls": 0,
  "oracle_adopted": 0,
  "skills_used": [],
  "new_skills": [],
  "scripts_used": [],
  "new_scripts": [],
  "manual_activities": [],
  "failures": [],
  "rework_items": [],
  "tests_run": [],
  "follow_up_candidates": []
}
```

## Metrics

- Large-model action share.
- Small-model delegation share.
- Oracle adoption rate.
- Skill reuse count.
- New skill count.
- Script automation count.
- Manual activity count.
- Failure recurrence risk.
- Rework count.

## Improvement Rules

- If a manual activity appears twice, propose a skill or script.
- If a large-model activity has a stable input/output contract, route it to a cheaper subagent.
- If a skill requires the same shell sequence repeatedly, move that sequence into a script.
- If Oracle repeatedly critiques the same type of issue, add a pre-Oracle checklist to the relevant skill.
- If the same routing decision recurs, update `references/team-roster.md` or an installed agent config instead of adding a new permanent agent.
