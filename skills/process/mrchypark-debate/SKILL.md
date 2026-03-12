---
name: mrchypark-debate
description: Use when an expensive-to-reverse decision has at least two viable options, unresolved tradeoffs, and would benefit from a grounded multi-perspective debate before committing.
---

# Instructions
- Use this only when all of the following are true:
- the decision is expensive to reverse
- there are at least two viable options
- the tradeoff is still unresolved after direct local inspection or verification
- Do not use this for routine edits, bug triage, yes-or-no factual checks, or questions that a single critique pass can settle.
- Start by grounding the topic. If the decision depends on repo facts, docs, constraints, or current behavior, dispatch `researcher` first and capture the hard constraints in `.codex/context/ACTIVE_TASK.md`.
- Write the debate question in one sentence. Include the current proposal, realistic alternatives, non-negotiable constraints, and the decision deadline if there is one.
- Run `debater` in parallel with two to four explicit perspectives. Default set:
- `advocate`: argue for the current proposal
- `skeptic`: attack assumptions, hidden risks, and failure modes
- `pragmatist`: focus on delivery cost, migration burden, maintenance load, and reversibility
- Add or swap one perspective only when the topic clearly needs it, for example `user-value`, `security`, or `performance`.
- Use the standard prompts in `references/handoff-templates.md`. Do not improvise perspective prompts unless the topic genuinely needs a different lens.
- Keep each debate handoff bounded. Point every participant at `.codex/context/ACTIVE_TASK.md`, specify the assigned perspective, and require:
- strongest argument
- top risks or objections
- assumptions that would change the conclusion
- concrete recommendation
- Save the raw outputs to `.codex/context/DEBATE_LOG.md` only when the debate needs to survive a later handoff or asynchronous review. Otherwise quote the participant outputs directly into the moderator handoff.
- Do not overwrite `ACTIVE_TASK.md` with the transcript.
- Dispatch `moderator` after the debate finishes. Require a synthesis with:
- points of agreement
- points of disagreement
- decision criteria that actually matter
- recommended direction
- what must be verified before committing
- Present the synthesis to the user in plain language. Lead with the recommendation, then summarize why, what the strongest objection was, and what evidence would change the answer.
