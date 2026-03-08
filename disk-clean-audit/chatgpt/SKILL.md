---
name: disk-clean-audit-chatgpt
description: ChatGPT-specific disk cleanup audit skill for macOS. Use when you want a read-only disk usage audit with an info.md knowledge base, fresh capacity measurement on every run, and Korean reporting that proposes only manual cleanup commands.
---

# Disk Clean Audit (ChatGPT)

## Overview

Use this variant when packaging the disk cleanup audit workflow for ChatGPT-oriented execution. Follow the shared `disk-clean-audit` rules first, then apply this variant for clearer task framing and structured reporting.

## Core Capabilities

### 1. Read-only audit

- refresh capacity data on every run
- reuse semantic analysis from `info.md`
- avoid destructive actions entirely

### 2. Targeted deep investigation

- investigate only new, under-documented, or sharply changed paths
- keep evidence-driven folder meaning separate from fresh size measurement

### 3. Actionable reporting

- report in Korean
- propose confirmation commands before any manual cleanup commands
- distinguish `safe`, `caution`, `forbidden`, and `restricted` paths conservatively

## Recommended Workflow

1. Read `info.md`.
2. Run the required capacity commands again.
3. Reuse prior folder semantics where evidence is still sufficient.
4. Deep-dive only on uncertain or changed paths.
5. Update `info.md` with changed facts only.
6. Produce the ordered final report in Korean.

## Risk Controls

- Never execute deletion commands.
- Never run `sudo`.
- Never modify anything except `info.md`.
- Never classify uncertain paths as `safe`.

## Common Mistakes

- re-analyzing every folder instead of reusing `info.md`
- mixing fresh size measurement with stale semantics
- suggesting destructive commands as if they should be executed now
- retrying restricted paths repeatedly
