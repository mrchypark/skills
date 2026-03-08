---
name: disk-clean-audit-claude
description: Use when auditing macOS disk usage with an info.md knowledge base, refreshing capacity on every run, and proposing only manual cleanup commands in Korean without executing deletion.
---

# Disk Clean Audit (Claude)

## Overview

Follow the shared `disk-clean-audit` contract. This variant keeps the operating instructions concise for Claude-oriented execution.

## When to Use

Use this skill when:

- you need a read-only macOS disk usage audit
- you want to reuse prior folder meaning from `info.md`
- you need fresh capacity measurements on every run
- you want Korean reporting with manual cleanup suggestions only

Do not use this skill when:

- the task requires actual deletion or cleanup execution
- `sudo` is expected
- you need to modify anything other than `info.md`

## Quick Reference

- Read `info.md` first.
- Always rerun:
  - `date`
  - `sw_vers`
  - `df -h /`
  - `df -h`
  - `du -x -d 1 / 2>/dev/null | sort -hr | head -n 80`
- Reuse semantics from `info.md` unless the path is new, unclear, or changed sharply.
- Report in Korean and list confirmation commands before manual cleanup commands.

## Common Mistakes

- executing cleanup commands instead of only proposing them
- recreating duplicate sections in `info.md`
- marking uncertain folders as `safe`
- repeating restricted-path probes after permission errors
