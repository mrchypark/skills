---
name: remote-review
description: Use when addressing remote code review comments through external review tools or web UIs, especially when Codex must choose and remember reviewer tools, process review threads, reply with rationale, resolve comments, commit accepted fixes, and re-request review until all threads are closed or tool quotas are exhausted.
---

# Remote Review

## Overview

Use this skill to clear remote review threads end-to-end instead of treating review comments as read-only input.

Persist the user's preferred review tools and execution order the first time. On later runs, reuse that preference, process unresolved review comments, and continue until all review threads are handled or every allowed tool is exhausted.

## 1. Establish the Tool Registry

On the first run for a repository or host, ask which remote review tools are allowed and should be attempted first.

Collect:

- candidate tools that can read threads, post replies, resolve threads, request re-review, and ideally expose quota or failure state
- the preferred order
- whether the preference should be stored per-project or globally

If no stored preference exists, ask before proceeding. Do not silently invent storage scope.

If a preference already exists, reuse it unless the user explicitly changes it.

Examples of candidate tools:

- provider CLI APIs such as `gh`
- provider MCP tools
- browser automation as a fallback when the API path is missing or degraded

## 2. Persist the Preference

Record the preference in a machine-editable file so later runs can continue without asking again.

Recommended locations:

- project-local: repository-scoped file such as `.codex/remote-review.toml`
- global: user-scoped file such as `$CODEX_HOME/remote-review/<provider-or-host>.toml`

Store at least:

- `storage_scope`
- `tool_order`
- `tool_capabilities`
- `last_confirmed_at`

Keep the schema small. Do not create multiple competing files for the same scope.

## 3. Choose the Active Strategy

Use the ordered tools as a failover chain.

Rules:

- prefer the first healthy tool in the stored order
- use parallelism only for read-only work such as fetching open threads, loading comment context, or checking tool health
- perform state-changing actions one thread at a time: replying, resolving, requesting review, or any server-side mutation
- if the active tool reports quota exhaustion, hard rate limit, auth failure, or missing capability, move to the next tool in the stored order
- if a tool is merely slow but still healthy, do not switch unless it blocks the loop materially

Think of the strategy as `parallel reads, serialized writes, ordered fallback`.

## 4. Run the Review Loop

Repeat this loop until no unresolved remote review comments remain or every allowed tool is exhausted.

### Step A: Refresh the Queue

Fetch the current unresolved review threads from the active tool.

Include:

- thread URL or identifier
- reviewer identity if available
- exact comment text
- referenced file and line if available
- current thread state

### Step B: Evaluate the Thread

For each unresolved thread:

1. Inspect the cited code and surrounding context.
2. Decide whether the review comment is correct, partially correct, stale, or should be declined.
3. Never implement blindly. Verify the technical claim against the code and the current branch state.

### Step C: If Not Applying the Suggestion

When declining or partially declining:

- post a concise reply explaining why the change is not being applied
- mention the relevant constraint, invariant, or existing behavior
- if partially applied, separate what changed from what was declined
- resolve the thread after the explanation if the platform allows it

Do not leave a silent resolve.

### Step D: If Applying the Suggestion

When accepting the comment:

- implement the change
- run the smallest meaningful verification for that change
- post a reply explaining what changed
- commit the accepted fix before resolving the thread
- resolve the thread after the reply and commit succeed

Prefer one logical commit per review thread unless multiple comments are clearly the same fix.

### Step E: Re-request Review

After all currently visible unresolved threads are handled for the active pass:

- push the branch if needed
- request review again through the active tool if supported
- refresh the unresolved queue

If new comments arrive, continue the loop.

## 5. Replying Style

Keep replies short, technical, and specific.

Accepted comment reply pattern:

```text
Applied in <commit-or-branch-update>. Changed <what changed> to address <issue>. Verified with <test or check>.
```

Declined comment reply pattern:

```text
Not applying this because <technical reason>. The current behavior preserves <invariant or compatibility point>. Reviewed against <relevant context>.
```

If the platform supports richer review replies, still keep the substance concise.

## 6. Resolution Rules

Resolve a thread only after one of these is true:

- the requested fix is implemented, verified, committed, and explained
- the suggestion is declined with an explicit rationale
- the thread is stale and the reply explains why it is no longer applicable

Do not resolve comments without a visible explanation.

## 7. Stopping Conditions

Stop only when one of these is true:

- there are no unresolved review threads left
- every allowed tool is exhausted or unusable
- the remote platform refuses further actions and no fallback remains

If stopping due to exhaustion or failure, report:

- which threads remain unresolved
- which tools were attempted
- why each failed or became unavailable

Do not claim completion in this case.

## 8. Guardrails

- Do not ask for tool choice again if a stored preference exists and still works.
- Do not mutate multiple remote review threads in parallel.
- Do not resolve before replying.
- Do not reply that a fix was made until the change is committed.
- Do not request re-review before the current batch of handled comments is pushed.
- Do not continue retrying one dead tool forever; move down the ordered fallback list.
- Do not hide quota exhaustion. If all tools are out, stop.
