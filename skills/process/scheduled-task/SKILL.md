---
name: scheduled-task
description: Use when converting a repeated or time-triggered task into a Codex automation, monitor, reminder, or scheduled work protocol.
---

# Scheduled Task

Use this for recurring work that should run later and produce an auditable report. It adapts GenericAgent's `reflect/scheduler.py` pattern without copying its file-polling runtime.

## Boundary

- Use Codex automation tools when the user asks to create, update, view, or delete real automations.
- Use this skill to shape the task contract before registering an automation.
- Do not use this for one-off implementation plans.
- Do not create autonomous write actions unless the user explicitly approved the recurring side effect.

## Task Contract

Every scheduled task needs:

| Field | Requirement |
|---|---|
| Purpose | One sentence describing the recurring outcome |
| Trigger | Exact schedule, interval, monitor condition, or reminder time |
| Freshness window | When a late run should be skipped or downgraded |
| Inputs | Files, channels, URLs, repos, APIs, or user context needed |
| Allowed actions | Read-only, draft-only, report-only, or approved writes |
| Report target | Where the result should be posted or saved |
| Verification | How to prove the run did useful work |
| Stop condition | When recurrence should end or ask for renewal |

## Safety Defaults

- Default to read-only plus report.
- Prefer drafts over sending messages or mutating external systems.
- Add a freshness window for daily or market/news tasks.
- Include an explicit "no data" report path instead of silently doing nothing.
- Keep credentials, tokens, and private identifiers out of task definitions.

## Report Shape

Use a compact report with:

```markdown
# <task> Run Report

- Triggered at:
- Inputs checked:
- Actions taken:
- Findings:
- Verification:
- Follow-up needed:
```

## Boundary

This skill defines recurring task contracts. It does not replace:

- design work for new feature behavior.
- implementation plans.
- fresh verification evidence before completion claims.
- existing agent roles for multi-agent execution inside a run.
