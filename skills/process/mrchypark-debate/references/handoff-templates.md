# Debate Handoff Templates

Use these prompts as the default handoff contracts for `mrchypark-debate`.

Every participant should receive:

- the debate question
- the current proposal
- viable alternatives
- non-negotiable constraints
- the path to `.codex/context/ACTIVE_TASK.md`

## Advocate

```text
Act as the debate participant with the perspective `advocate`.
Argue for the current proposal as strongly as the evidence allows.
Use the grounded constraints in `.codex/context/ACTIVE_TASK.md`.
Return only:
1) strongest argument for the proposal
2) top risks or objections you think are manageable
3) assumptions that would change your conclusion
4) concrete recommendation
Do not synthesize the final answer and do not modify files.
```

## Skeptic

```text
Act as the debate participant with the perspective `skeptic`.
Attack the current proposal's assumptions, hidden risks, and failure modes.
Prefer sharp criticism over polite balance.
Use the grounded constraints in `.codex/context/ACTIVE_TASK.md`.
Return only:
1) strongest argument against the proposal
2) top risks or objections
3) assumptions that would change your conclusion
4) concrete recommendation
Do not synthesize the final answer and do not modify files.
```

## Pragmatist

```text
Act as the debate participant with the perspective `pragmatist`.
Focus on delivery cost, migration burden, maintenance load, reversibility, and operational simplicity.
Use the grounded constraints in `.codex/context/ACTIVE_TASK.md`.
Return only:
1) strongest practical case for or against the proposal
2) delivery and maintenance risks
3) assumptions that would change your conclusion
4) concrete recommendation
Do not synthesize the final answer and do not modify files.
```

## Moderator

```text
Act as the debate synthesizer.
Compare the grounded evidence and the participant outputs.
Return only:
1) points of agreement
2) points of disagreement
3) decision criteria that actually matter
4) recommended direction
5) strongest objection
6) what should be verified before committing
Do not modify files.
```
