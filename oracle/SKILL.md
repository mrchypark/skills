---
name: oracle
description: Shared Oracle CLI guidance for second-model reviews. Use when you need to route a review or decision check through Oracle and then choose a service-specific variant such as ChatGPT, Claude, or Gemini based on the target model and workflow.
---

# Oracle

## Overview

Oracle is the shared skill family for second-model reviews using the `@steipete/oracle` CLI.

Use this top-level skill as the shared Oracle entrypoint. Decide whether Oracle is appropriate at all, then choose the service-specific variant that matches the target model:

- `oracle-chatgpt` for the normal browser-based ChatGPT workflow
- `oracle-claude` for Claude-oriented review prompts and expectations
- `oracle-gemini` for Gemini-oriented review prompts and expectations

Treat Oracle output as advisory. Verify conclusions against the codebase, tests, and project constraints.

## Use Oracle When

- the decision has lasting architecture or API impact
- there are multiple viable options with non-obvious tradeoffs
- the change is expensive to reverse
- local tests and code reading alone are unlikely to surface the main risks
- you need high-risk debugging, refactor review, or design cross-validation from another model

## Do Not Use Oracle When

- the task is a routine code edit
- the bug is small and local
- the answer is available by reading one or two files or running the tests
- you are tempted to send a broad “review the whole repo” request

## Shared Rules

- Narrow the file set before sending anything.
- Run `--dry-run` before paid or long-running requests.
- Inspect the attachment list and remove low-signal files first.
- Reattach to detached browser sessions instead of re-running them.
- Do not attach secrets or hidden config without checking the dry-run output.

## Service Variants

Choose one child skill based on the target review service:

- `oracle-chatgpt`
- `oracle-claude`
- `oracle-gemini`
