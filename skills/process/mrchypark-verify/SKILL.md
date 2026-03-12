---
name: mrchypark-verify
description: Use when you need to prove the work behaves as expected before review.
---

# Instructions
- Run the narrowest relevant automated checks first, then add manual verification only where automation does not cover the risk.
- Record the exact commands, the outcome, and any important context such as environment, fixtures, or seed data.
- If a check is skipped, flaky, or unavailable, say so directly and explain what weaker signal you relied on instead.
- Verify requested behavior, not just command exit codes. A green command that misses the user requirement does not count.
- In orchestrated work, this is the parent session's acceptance gate. Do not accept delegated output or claim the work is complete until you can point to concrete evidence.
