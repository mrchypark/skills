# Build Patterns

Use this file after the brief is accepted.

## Shared defaults

- Establish the design system before composing many components.
- Define semantic colors, typography roles, spacing rhythm, and surface rules early.
- Limit the visual system unless the product already has a mature brand language.
- Make one idea dominant in each section or region.
- Use real copy, real product names, real metrics, and real imagery whenever available.
- Remove filler. If cutting a third of the copy improves the page, keep cutting.
- Preserve established patterns when working inside an existing product.

## Landing pages

- Treat the first viewport like a poster.
- Put the brand or product identity first.
- Keep the hero focused on one promise, one primary action, and one dominant visual anchor.
- Prefer full-bleed or visually dominant hero treatments when the brief supports it.
- Keep the hero free of detached badges, stat strips, logo clouds, and dashboard fragments unless the product genuinely needs them.
- Keep headline and support copy short enough to scan in one glance.
- Use a narrative sequence by default: identity, support, depth, proof, conversion.

## Product UI and dashboards

- Start with the working surface, not a marketing hero, unless the user explicitly asks for one.
- Organize the screen around primary workspace, navigation, and secondary context.
- Favor calm surfaces, strong typography, and readable density.
- Use cards only when they are the interaction container or meaningfully improve grouping.
- Prefer layout structure over a mosaic of bordered panels.
- Write utility copy. Headings should tell the operator what the area is or what they can do there.
- Remove ornamental icons and decorative gradients that do not improve scanning.

## Imagery

- Use imagery only when it does narrative work.
- Prefer real-looking, in-context imagery over abstract filler.
- Choose images with calm tonal zones when text must sit on top.
- Avoid imagery that competes with the interface using embedded signage or dense typography.
- Use multiple images for multiple moments instead of one collage.

## Motion

- Use motion to improve hierarchy, affordance, or atmosphere.
- Ship a small number of intentional motions for visually led work.
- Favor one entrance sequence, one depth or scroll effect, and one interaction-level motion.
- Keep motion smooth on mobile and remove it if it is ornamental only.
- Keep fixed and floating elements away from core content at every breakpoint.

## Copy

- Write in product language, not design commentary.
- Let the main headline carry the meaning.
- Keep support copy brief and specific.
- Give every section a distinct responsibility: explain, prove, deepen, orient, or convert.
- For dashboards and tools, prefer status, scope, freshness, and next action over brand slogans.

## Technical defaults

- Encode tokens with CSS variables or the local token system.
- Prefer the repository's existing stack first.
- Use React plus Tailwind as a default only when no stronger local constraint exists.
- Ensure the first screen works on common desktop and mobile sizes.
- Verify contrast, spacing, scroll behavior, and tap targets before closing.
