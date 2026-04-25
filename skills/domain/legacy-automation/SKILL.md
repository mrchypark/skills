---
name: legacy-automation
description: Use when evaluating, wrapping, porting, using, or operating GenericAgent-style browser, ADB, OCR, keyboard, mouse, CDP, or raw system-control automation in Codex.
---

# Legacy Automation

GenericAgent's strongest capabilities come from raw local control: script execution, real-browser CDP, keyboard and mouse input, screen vision, OCR, ADB, and generated helper scripts. In Codex, treat these as legacy automation capabilities that require explicit boundaries.

## Boundary

Prefer native Codex tools first:

| Need | Preferred path |
|---|---|
| Local file or code work | Codex filesystem and shell tools |
| Web testing | Browser Use or Playwright |
| GitHub work | GitHub plugin and `gh` |
| Durable memory | Yeoul |
| Scheduling | Codex automations |

Use this skill only when the preferred path cannot provide the needed fidelity, such as a real logged-in browser session, Android device control, local GUI automation, OCR over an app window, or CDP-only browser behavior.

## Required Guardrails

Before enabling a legacy wrapper, define:

1. The exact external surface: browser profile, app, device, directory, or API.
2. Allowed operations: read-only, screenshot, click, type, upload, send, delete, install.
3. Confirmation points for irreversible or externally visible actions.
4. Evidence capture: screenshot, log, exported file, or command output.
5. Cleanup and rollback behavior.

If the wrapper crosses accounts, payments, messaging, deletion, device state, or secrets, stop for user confirmation before the action.

## Wrapper Rules

- Expose narrow commands, not raw arbitrary code.
- Keep credentials outside the wrapper and never log them.
- Prefer dry-run and inspect modes.
- Time-limit and output-limit every command.
- Fail closed when the target window, tab, device, or selector is ambiguous.
- Save evidence to a user-visible path when the action affects external state.

## Boundary

This skill is not a planning, debugging, TDD, or verification replacement. Use it only for the automation substrate. Pair it with:

- systematic debugging when automation fails unexpectedly.
- fresh verification evidence before claiming completion.
- existing agent roles when isolating a legacy wrapper implementation.
- `review-loop` for wrappers that touch trust boundaries or external accounts.
