# Cost Optimization Loop

## Purpose

After each substantial task, identify work that should not require the same model effort next time.

## Classification

Classify each material activity:

- Large model: orchestration, high-risk decisions, final integration.
- Small model: exploration, metrics, bounded evaluation, checklist execution.
- Skill: repeated workflow with judgment.
- Script/code: deterministic repeated work.
- Manual: rare, unstable, or not yet understood.

## Conversion Rules

- Convert manual activity to a skill when it has a stable trigger and repeated judgment.
- Convert manual activity to a script when the input/output is structured and deterministic.
- Convert large-model activity to a small-model subagent when the task has a bounded output contract.
- Keep activity manual when the pattern is not repeated or the cost of abstraction is higher than reuse.
- Use Oracle only when the reversal cost justifies external GPT-5.5 Pro critique.

## Metrics To Track

- Large-model action share.
- Small-model delegation share.
- Oracle call count and adoption rate.
- Skill reuse count.
- New skill count.
- Script automation count.
- Manual activity count.
- Failure and rework count.

## Review Cadence

- Review after every substantial task.
- Consolidate after three to five similar tasks.
- Update role cards, skill references, or scripts when the same recommendation appears twice.
