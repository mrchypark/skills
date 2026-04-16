---
name: frontend-delight
description: "Use when designing or building a frontend where visual quality matters: landing pages, marketing sites, dashboards, product surfaces, prototypes, redesigns, or major UI refactors. This skill forces a design-brief intake before implementation, asks the user for missing product, brand, content, and reference inputs, then guides a polished modern build with strong hierarchy, restrained composition, clear design tokens, real content, safe motion, and mobile-ready execution."
---

# Frontend Delight

## Overview

Turn a vague UI request into a defended design brief before writing code. Build from that brief so the result feels intentional, contemporary, and specific to the product instead of generic template UI.

## Non-Negotiables

- Read the smallest useful set of local files first. Check the existing product, component library, CSS system, brand assets, and any current design language before suggesting a new direction.
- Do not start implementation until a usable brief exists. Either collect the missing inputs from the user or state explicit assumptions and get confirmation.
- Do not write code until the user approves the brief or explicitly tells you to proceed with the stated assumptions.
- Ask only the questions that materially change the design. Avoid a long ceremonial interview. Prioritize blockers.
- Offer concrete options when the user is unsure. Give two or three art directions, not abstract taste talk.
- Preserve an existing design system unless the user explicitly wants a new visual direction.
- Ground the build in real product context, real copy, real data, and real assets whenever possible.

## Workflow

1. Read project context.
   - Inspect the current app, design tokens, routes, and reusable components.
   - Load [references/openai-gpt54-notes.md](references/openai-gpt54-notes.md) if you need the distilled OpenAI guidance behind this skill.
2. Run the intake.
   - Load [references/discovery-brief.md](references/discovery-brief.md).
   - Ask for the highest-leverage missing inputs first: product goal, audience, surface type, references, content, assets, constraints.
   - If the user gives weak or incomplete direction, propose art-direction options and ask them to choose.
3. Write a compact design brief in the conversation before coding.
   - Include `visual thesis`, `content plan`, `interaction thesis`, `token plan`, and `implementation constraints`.
   - Keep it short enough to scan.
   - Ask for approval or corrections before implementation.
4. Build from the brief.
   - Load [references/build-patterns.md](references/build-patterns.md).
   - Choose patterns based on the surface: landing page, app shell, dashboard, or mixed product marketing.
5. Review the result before claiming completion.
   - Load [references/review-rubric.md](references/review-rubric.md).
   - Fix hierarchy, clutter, weak copy, unsafe overlays, and mobile regressions before closing out.

## Output Contract

Before implementation, produce a brief with these fields:

- `surface`: what is being built and where it lives
- `user + job`: who uses it and what they need to do first
- `visual thesis`: one sentence for mood, material, and energy
- `content plan`: the sections or regions and each one job
- `interaction thesis`: two or three motions or interaction ideas
- `design tokens`: color roles, typography roles, spacing character, radius/shadow posture
- `asset plan`: what real copy, imagery, logos, data, or screenshots are available or missing
- `constraints`: stack, responsiveness, accessibility, localization, deadlines, existing system rules

If critical inputs are missing, say so plainly and ask for them before building.
If the user wants to move fast, keep the brief compact, list your assumptions explicitly, and ask for a go or correction in the same message.

## Defaults

- Default to strong composition before component detail.
- Default to one dominant visual idea per section.
- Default to short, believable copy instead of placeholders.
- Default to a small token system: limited typefaces, limited accent colors, clear semantic roles.
- Default to real layout structure instead of card mosaics.
- Default to motion that improves hierarchy or atmosphere, not decoration.
- Default to mobile-safe spacing and non-overlapping fixed elements.
- Default to React plus Tailwind only when the local project has no stronger constraint.

## Resource Map

- Use [references/discovery-brief.md](references/discovery-brief.md) to drive the pre-build interview.
- Use [references/build-patterns.md](references/build-patterns.md) while implementing.
- Use [references/review-rubric.md](references/review-rubric.md) to critique and polish the result.
- Use [references/openai-gpt54-notes.md](references/openai-gpt54-notes.md) when you need the rationale behind the rules.
- Use [references/example-flows.md](references/example-flows.md) when you need concrete sample prompts and model responses.
