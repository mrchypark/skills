---
name: disk-clean-audit
description: Shared disk cleanup audit guidance for macOS. Use when auditing disk usage with an info.md knowledge base, re-measuring capacity on every run, and proposing manual cleanup commands without executing deletion.
---

# Disk Clean Audit

## Overview

This is the shared root skill for read-only macOS disk cleanup audits.

Core principle:

- capacity is always fresh
- semantics are knowledge-base-first

Use this parent skill for the common contract, then choose a service-specific variant when you want packaging tuned for ChatGPT, Claude, or Gemini:

- `disk-clean-audit-chatgpt`
- `disk-clean-audit-claude`
- `disk-clean-audit-gemini`

## Non-Negotiables

- Never execute deletion or cleanup commands: `rm`, `mv`, `trash`, `find -delete`, `brew cleanup`, `docker system prune`, and similar destructive cleanup actions are forbidden.
- Never run `sudo` directly.
- Never modify files other than `info.md`.
- Always produce the final report in Korean.

## Execution Contract

1. Read `info.md` first at the start of every run. Create it if it does not exist.
2. Re-run the capacity commands on every audit:
   - `date`
   - `sw_vers`
   - `df -h /`
   - `df -h`
   - `du -x -d 1 / 2>/dev/null | sort -hr | head -n 80`
3. Reuse meaning and purpose from `info.md` before re-analyzing folders.
4. Only investigate deeply when a path is new, under-documented, or changed sharply.
5. Keep capacity refresh and semantic analysis separate:
   - capacity is always refreshed
   - meaning is updated only when new evidence exists

## Folder Analysis Rules

- Do not infer folder meaning from the name alone.
- Use internal structure, representative files, modification times, and local code or documents as evidence.
- If uncertain, do not mark a path as `safe`.
- Record repeated permission failures as `restricted` and stop retrying them.

## info.md Update Rules

- Do not create duplicate sections for the same path.
- Preserve the required fields:
  - `size`
  - `classification`
  - `purpose`
  - `created_by`
  - `current_usage`
  - `risk_if_removed`
  - `evidence`
  - `last_checked`
  - `confidence`
- Update size and timestamp facts every run.
- Update semantic fields only when new evidence exists.

## Reporting Rules

Always report in this order:

1. overall summary
2. folders reused from previous knowledge
3. folders newly investigated this run
4. cleanup candidates, with confirmation commands first and manual commands after
5. caution, forbidden, or restricted folders
6. `info.md` update summary

If folder-based scanning does not explain the usage, mention possible APFS snapshots, swap, or sleepimage and provide confirmation commands only.
