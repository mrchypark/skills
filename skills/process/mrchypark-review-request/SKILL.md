---
name: mrchypark-review-request
description: Use when the changes are ready for peer review and need targeted feedback.
---

# Instructions
- Summarize the change in two to three sentences with the user-facing impact and the highest-risk areas.
- Point to the key files, behaviors, or migrations that deserve attention instead of asking for a vague whole-repo review.
- List the exact verification you already ran and the checks you intentionally did not run.
- Call out known risks, incomplete areas, or assumptions that deserve reviewer scrutiny.
- Ask one explicit review question when you need an answer on a specific trade-off, regression risk, or design choice.
- Use the lightest reviewer that matches the risk: local `reviewer` agent for correctness, external critique tools only when the decision is expensive to reverse.
- In orchestrated work, treat review as a separate handoff after local integration and `mrchypark-verify`, not as a substitute for either one.
