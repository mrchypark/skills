---
name: skillopt-skill-optimization
description: Use when optimizing, evolving, validating, or reducing drift in an existing Codex or agent skill from scored rollouts, benchmark traces, verifier feedback, rejected edits, or held-out evaluation results.
---

# SkillOpt Skill Optimization

Optimize a skill as a compact external state for a frozen agent. Adapted from SkillOpt: use scored rollouts to propose bounded text edits, accept only held-out improvements, and export a small auditable skill artifact.

## Scope Contract

- Use this for an existing or draft skill whose behavior can be evaluated with scores, pass/fail checks, verifier feedback, review findings, or repeated task outcomes.
- Keep the target model, harness, tools, and evaluator fixed during one optimization run.
- Optimize one portable skill artifact by default. Propose a skill library only when the domain clearly has disjoint procedures.
- Do not merge every reflection into the skill. Treat unvalidated edits as hypotheses.
- Do not claim generalization from training or selection scores alone; reserve a held-out test or fresh task set for final reporting.

## Required Inputs

Before editing, identify:

| Input | Requirement |
|---|---|
| Current skill | Path and current text to optimize |
| Target setting | Model, harness, tools, and task surface the skill is meant to guide |
| Evaluator | Automatic score, tests, verifier, reviewer rubric, or explicit pass/fail rule |
| Splits | Training evidence, selection gate, and final test/fresh tasks |
| Budget | Maximum edits per step, maximum rounds, and acceptable offline cost |
| Deployment boundary | What the final skill may assume at inference time |

If no reliable evaluation signal exists, first create a small rubric and fresh validation tasks. Do not run SkillOpt-style editing as pure subjective rewriting.

## Optimization Loop

1. **Baseline**
   - Evaluate the current skill on the selection set and at least a small fresh sample.
   - Record the score, failures, successful behaviors worth preserving, and skill hash or diff base.

2. **Rollout evidence**
   - Run the frozen target agent with the current skill on training tasks.
   - Capture trajectories: prompt, tool calls, observations, command outputs, final answer, verifier feedback, and score.
   - Separate failures from successes. Failures propose repairs; successes protect useful behavior.

3. **Minibatch reflection**
   - Analyze multiple trajectories at once.
   - Extract recurring procedural patterns, not one-off examples.
   - For failures, propose missing or corrective rules.
   - For successes, propose only preservation rules not already covered by the skill.

4. **Bounded edits**
   - Express each proposed change as one of: `append`, `insert_after`, `replace`, or `delete`.
   - Rank edits by systematic impact, complementarity, generality, and actionability.
   - Apply at most the current textual learning rate `L_t` edits. Prefer `L_t=1-4` unless evidence is broad and the skill is underdeveloped.
   - Use larger edits early and smaller consolidation edits later.

5. **Validation gate**
   - Evaluate the candidate skill on the selection set with the same target model, harness, and evaluator.
   - Accept only if the selection score is strictly better than the current accepted skill.
   - If accepted, update the current skill; if best so far, mark it as the export candidate.
   - If rejected, keep the attempted diff and score drop in a rejected-edit buffer.
   - If candidate scores are unavailable, label edits as `proposed`, not `accepted`, and stop before modifying the deployed skill.

6. **Slow update**
   - At epoch boundaries, compare the same tasks under the previous accepted skill and the current skill.
   - Group outcomes as improvements, regressions, persistent failures, and stable successes.
   - Add only short strategic guidance that prevents regressions or fixes persistent failures.
   - Validate slow-update changes through the same selection gate.

7. **Final test**
   - Evaluate the best selection-gated skill on held-out or fresh tasks not used for edit decisions.
   - Report baseline, selected score, final score, accepted edits, rejected edit themes, and remaining risks.

## Edit Quality Rules

- Prefer procedural rules over benchmark-specific answers, filenames, entities, or hidden test hints.
- Preserve trigger behavior in the frontmatter unless the trigger itself caused measurable misuse.
- Keep the deployed skill compact enough to audit quickly. Remove stale, duplicated, or contradicted rules.
- Make each rule actionable: say what to do, when to do it, and what evidence should trigger it.
- Protect known-good behavior. Do not delete a working rule unless repeated evidence shows it hurts.
- Treat rejected edits as negative feedback, not as content to reword and force back in.

## Output Format

When reporting an optimization run, use:

```markdown
# Skill Optimization Report

- Skill:
- Target model/harness:
- Evaluator:
- Train/selection/test split:
- Baseline:
- Accepted edits:
- Proposed edits pending validation:
- Rejected edit themes:
- Selection result:
- Final held-out result:
- Deployment artifact:
- Residual risks:
```

## Common Mistakes

- Editing from a single vivid failure instead of a recurring minibatch pattern.
- Accepting plausible advice without held-out improvement.
- Reporting proposed edits as accepted edits before candidate validation.
- Letting selection data become the final test.
- Growing the skill into a transcript of every reflection.
- Mixing optimizer-only notes into the deployed skill.
- Changing the model, harness, or evaluator mid-run and attributing the result to the skill.
