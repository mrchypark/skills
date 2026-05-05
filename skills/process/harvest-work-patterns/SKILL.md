---
name: harvest-work-patterns
description: Audit the current conversation thread and active workspace to extract evidence-backed reuse opportunities. Use when Codex should review ongoing work and identify (1) common code or shared utility candidates, (2) tasks that should become new or improved skills, and (3) recurring operating rules that should be formalized for future runs. Also use when deciding whether findings should be recorded in Yeoul or proposed as recurring automation.
---

# Harvest Work Patterns

## Overview

Read the current thread and the active workspace together, then turn repeated work into a prioritized audit. Focus on three outputs only: common code candidates, skill candidates, and recurring operating rules.

Prefer evidence-backed recommendations over clever abstraction. If the pattern is weak, keep it as a watch item instead of forcing a skill, helper, or automation.

## Scope Contract

- Treat `current thread` as the messages visible in the active conversation only.
- Treat `active workspace` as the current repository or working directory plus files directly inspected for this audit.
- Search Yeoul first when prior decisions, constraints, ownership, status, tradeoffs, or provenance may affect the recommendation.
- Do not assume older sessions are in scope unless the user includes them or durable memory clearly applies.
- Do not edit product code, rewrite unrelated files, write Yeoul memory, or create automations by default. Surface those as follow-up actions unless the user explicitly asks to materialize them now.

## What To Inspect

1. Read the thread end to end before extracting patterns.
2. Inspect the workspace structure and the local files that explain repetition:
   - existing skills
   - repo docs and plans
   - scripts, templates, and helper modules
   - recent diffs only when they show the same work recurring
3. Check whether an existing skill, script, or rule already covers the pattern before proposing a new abstraction.
4. Use `yeoul-memory` when durable project memory is likely to change the recommendation.

## Extraction Workflow

1. Orient
   - Read the thread.
   - Map the workspace quickly with `rg --files`, targeted file reads, and existing skill directories.
   - Note user-specific standing instructions that keep recurring.
2. Gather evidence
   - Capture repeated commands, repeated report shapes, repeated review gates, repeated scaffolds, repeated lookup patterns, and repeated follow-up decisions.
   - Prefer concrete evidence such as file paths, commands, turns, or prior written rules.
3. Classify
   - Put deterministic helpers and repeated utility logic into `common code candidates`.
   - Put repeated multi-step workflows with stable triggers into `skill candidates`.
   - Put repeated review gates, formatting rules, memory rules, or operational cautions into `recurring operating rules`.
4. Score
   - Use `high` confidence when there are at least two strong signals or one repeated high-cost pain point with a clear stable shape.
   - Use `medium` confidence when the pattern is visible but the exact boundary is still fuzzy.
   - Use `low` confidence only for a watch item. Do not recommend immediate abstraction from low-confidence evidence.
5. Prioritize
   - Mark `now` when the pattern is already slowing current work.
   - Mark `next` when the pattern is real but can wait until the current task closes.
   - Mark `later` when the pattern is plausible but still needs more evidence.

## Classification Rules

### Common Code Candidates

- Recommend this bucket when the same shell sequence, parser, formatter, scaffold, validation helper, or reporting generator keeps reappearing.
- Prefer a script, shared module, template, or helper function when determinism matters more than open-ended judgment.
- Do not recommend commonization when the repetition is only superficial naming overlap.

### Skill Candidates

- Recommend this bucket when the repeated work needs judgment plus a stable workflow, not just a script.
- Include the likely trigger phrase, the reusable workflow, and the resources that would belong in the skill:
  - `scripts/` for deterministic helpers
  - `references/` for domain rules or detailed checklists
  - `assets/` for templates or boilerplate artifacts
- Do not propose a new skill when a short repo note, alias, or one-off helper is enough.

### Recurring Operating Rules

- Recommend this bucket for standing instructions that keep resurfacing:
  - reporting format
  - validation expectations
  - review or escalation gates
  - memory-write rules
  - automation guards
- State where the rule should live:
  - skill body
  - Yeoul durable memory
  - automation prompt
  - repo doc or template

## Yeoul And Automation Gates

### Yeoul

- Suggest a Yeoul write only for durable information:
  - confirmed decisions
  - stable constraints
  - ownership changes
  - status changes
  - corrected rules with reasons
  - repeated problems and their resolution
- Search before suggesting a write so you do not duplicate or conflict with existing memory.
- Prefer `fact supersede` or `fact retract` with a reason when state changes.
- If the rule is local to one repo or one temporary task, prefer a skill or repo doc instead of durable memory.

### Automation

- Suggest automation only when all of these are true:
  - the work is clearly recurring
  - the trigger or cadence is understandable
  - the workspace or thread target is clear
  - the output expectation is stable
- Prefer a thread heartbeat when continuity in the same conversation matters.
- Prefer cron only when the work should run separately from the current thread.
- Do not create or update an automation unless the user explicitly asks for it.

## Output Format

Return the audit in this order:

1. `Scope checked`
   - which thread span and which workspace files were actually inspected
2. `Evidence summary`
   - the strongest repeated patterns and where they were observed
3. `Common code candidates`
   - `pattern`
   - `evidence`
   - `suggested artifact`
   - `why reuse helps`
   - `confidence`
   - `priority`
4. `Skill candidates`
   - `recommended skill name`
   - `trigger`
   - `workflow to encode`
   - `resources to bundle`
   - `confidence`
   - `priority`
5. `Recurring operating rules`
   - `rule`
   - `evidence`
   - `where to encode it`
   - `confidence`
   - `priority`
6. `Recommended next actions`
   - immediate
   - optional
   - deferred
7. `Yeoul candidates` when durable memory is warranted
8. `Automation candidates` when recurring execution is genuinely justified

## Materialization Follow-Ups

If the user asks to turn one recommendation into an artifact, follow the smallest valid path:

- For common code: extract the helper, template, or script and keep the write scope narrow.
- For a skill: use `skill-creator`, define the trigger clearly, and keep the first version tight.
- For Yeoul: use `yeoul-memory` and record only durable facts with lifecycle discipline.
- For automation: confirm the target, cadence, and output contract before creating anything.

## Example Triggers

- "현재 쓰레드와 repo를 보고 반복 작업을 스킬 후보로 뽑아줘."
- "여기서 공통화할 코드, 스킬화할 작업, 규칙으로 고정할 운영 습관을 정리해줘."
- "이 프로젝트에서 Yeoul에 남길 사실과 자동화할 루틴 후보를 찾아줘."
