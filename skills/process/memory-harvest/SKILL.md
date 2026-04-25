---
name: memory-harvest
description: Use when a completed or long-running task may contain reusable procedural knowledge, durable constraints, automation candidates, or memory updates that should be harvested without bloating active context.
---

# Memory Harvest

Harvest reusable working knowledge after evidence-producing work. This adapts GenericAgent's layered memory idea to Codex: record only what future sessions cannot cheaply rediscover.

## Boundary

- Use `yeoul-memory` for durable facts, decisions, provenance, status, and lifecycle changes.
- Use `skill-creator` or `writing-skills` only when the reusable pattern deserves an actual skill.
- Harvest only after fresh verification evidence exists.
- Do not store volatile state, raw transcripts, temporary paths, one-off commands, or unverified reasoning.

## Harvest Gate

Create a memory or skill candidate only when all are true:

1. The task produced concrete evidence: command output, file diff, test result, browser proof, or user-confirmed decision.
2. The knowledge is likely to matter beyond this session.
3. Reconstructing it later would cost more than a small lookup.
4. The record can be expressed as a compact rule, pointer, or procedure.

If any condition fails, summarize in the final answer but do not persist it.

## Classification

| Finding | Destination |
|---|---|
| Stable decision, constraint, owner, status, correction | Yeoul fact or episode |
| Repeated procedure with non-obvious ordering or pitfalls | New or updated skill |
| Project-local convention | `AGENTS.md` or project docs |
| Scheduled recurring action | `scheduled-task` |
| Browser, ADB, OCR, or OS-control tactic | `legacy-automation` |
| Test or review discipline | Existing review and verification guidance |

## Procedure

1. List only verified findings and their evidence.
2. Classify each finding using the table above.
3. Prefer the smallest durable artifact:
   - Yeoul entry for a fact or decision.
   - A short skill patch for a reusable workflow.
   - A boundary note when the finding prevents future misuse.
4. If omission could be surprising, state what was intentionally not saved and why.

## Common Mistakes

- Turning a successful one-off task into a generic skill.
- Saving "what happened" instead of the future trigger and action.
- Replacing verification with memory writing.
- Duplicating process rules instead of linking to the current owner.
