---
name: codex-roundtable
description: "Use when running a local filesystem based Codex roundtable: multiple Codex sessions with assigned roles independently review the same prompt, write one Markdown response per role per round, and a judge or moderator synthesizes consensus, conflicts, blind spots, and the next round prompt. Use for local multi-agent deliberation, round-based review, moderator synthesis, or Fusion-style discussion without servers, databases, web UIs, polling, or complex locking."
---

# Codex Roundtable

Run a local Markdown-only roundtable across multiple human-opened Codex sessions.

## Structure

Use this layout:

```text
rooms/<topic>/
  brief.md
  participants.md
  rounds/
    0001/
      prompt.md
      architect.md
      skeptic.md
      builder.md
      reviewer.md
      judge.md
```

Use lowercase slug names for `<topic>`. Use 4-digit round numbers such as `0001`, `0002`.

## Core Rules

- Keep every artifact under `rooms/<topic>/`.
- Each participant reads `brief.md`, `participants.md`, the current round `prompt.md`, and the previous round `judge.md` when it exists.
- Each participant writes only one role file for the current round.
- Do not edit existing role files, previous rounds, or an existing `judge.md`.
- Put corrections, objections, and follow-ups in the next round.
- Treat a round as closed once `judge.md` exists.
- If the target file already exists, do not overwrite it. Stop and report the collision, or write `<role>.<session>.md` if the user asked for parallel same-role submissions.

## Roles

- `architect`: structure, core decisions, assumptions.
- `skeptic`: failure modes, contradictions, missing constraints.
- `builder`: simplest executable plan, file-level steps, operational reality.
- `reviewer`: quality bar, verification questions, mergeable and non-mergeable points.
- `judge`: synthesis only; do not introduce new arguments.

## Participant Output

Write role files in this shape:

```markdown
# <role> round <number>
Author:
Created:
Inputs:

## Position
## Findings
## Risks
## Questions for judge
```

Role focus:

- `architect.md`: proposal shape, assumptions, key decisions.
- `skeptic.md`: likely failures, contradictions, missing constraints.
- `builder.md`: smallest practical procedure and files to create.
- `reviewer.md`: quality criteria, test questions, agreement boundaries.

## Judge Output

The judge reads the current round's submitted role files and writes `judge.md`:

```markdown
# judge round <number>

## consensus
## contradictions
## unique_insights
## blind_spots
## missing_inputs
## decision_or_next_prompt
```

List missing expected role files under `missing_inputs`. If another round is needed, write the exact next `prompt.md` text under `decision_or_next_prompt`.

## Starting A Room

When asked to start a roundtable, create only the missing minimum files:

```text
rooms/<topic>/brief.md
rooms/<topic>/participants.md
rooms/<topic>/rounds/0001/prompt.md
```

Then give the user one prompt per role session and one judge prompt. Do not run the round yourself unless the user asks.

## Defer

Do not add servers, databases, web UIs, polling, lock files, automatic merging, voting, permissions, or archival systems until repeated manual use proves they are needed.
