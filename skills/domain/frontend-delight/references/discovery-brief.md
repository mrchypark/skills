# Discovery Brief

Use this file to collect only the missing inputs that materially affect the design.

## Intake order

Ask the highest-leverage question first. Do not dump the full questionnaire at once.

1. Clarify the surface.
   - What is being built: landing page, marketing site, dashboard, app screen, settings flow, onboarding, or something else?
   - Is this a new surface or a redesign of an existing one?
2. Clarify the goal.
   - What should the user understand, trust, or do in the first few seconds?
   - What is the primary action or decision?
3. Clarify the audience.
   - Who is the user?
   - What level of familiarity or urgency do they have?
4. Clarify the visual direction.
   - Is there an existing brand, design system, or reference product to match?
   - Are there screenshots, Figma links, websites, mood boards, or product examples?
5. Clarify the content.
   - What real copy, labels, metrics, screenshots, product names, or images already exist?
   - What content is mandatory?
6. Clarify the stack and constraints.
   - Which framework, CSS approach, and component library are already in use?
   - What responsive, accessibility, localization, performance, or deadline constraints matter?

## Asset request priority

When the user has real materials, ask for them in this order:

1. Brand assets
   - logo files, color guidance, typography guidance, existing token files
2. Visual references
   - Figma links, screenshots, competitor links, mood boards, currently liked pages
3. Content sources
   - product copy docs, headings, feature lists, pricing, testimonials, screenshots
4. Product evidence
   - analytics screenshots, dashboard samples, table schemas, chart requirements, UI states
5. Constraints
   - component library, supported breakpoints, accessibility bar, localization needs, deadlines

If the user does not have these, state what will be assumed and what placeholders will be fabricated.

## If the user is unsure

Offer concrete art directions and ask them to choose or blend them.

Example option set:

- `Editorial Minimal`: large type, strong whitespace, restrained palette, premium photography
- `Sharp Product`: crisp structure, confident contrast, compact copy, product-first clarity
- `Expressive Motion`: bolder color moments, deeper layering, memorable transitions, still readable

For very vague requests, pair the art direction with a one-line visual thesis.

- `Editorial Minimal`: museum-like calm, generous whitespace, tactile image crops
- `Sharp Product`: precise grid, crisp type, controlled contrast, analytical confidence
- `Expressive Motion`: cinematic depth, stronger color events, memorable but disciplined motion

Offer concrete content structures too.

Example structure options:

- `Narrative Landing`: hero, support, depth, proof, CTA
- `Operator Workspace`: nav, main work surface, filters, tables or charts, inspector
- `Hybrid Product Marketing`: marketing hero followed by working UI slices and proof

## Brief template

Write the brief in the conversation before coding.

```text
Design brief
- Surface:
- User + job:
- Primary action:
- Visual thesis:
- Content plan:
- Interaction thesis:
- Design tokens:
- Asset plan:
- Constraints:
- Explicit assumptions:
```

After writing the brief, ask one direct question:

```text
Approve this direction, or tell me what to change before I start building.
```

## Quality bar for the brief

- Make the `visual thesis` feel visual, not generic. Include mood, material, and energy.
- Make the `content plan` structural. Give each section or region one job.
- Make the `interaction thesis` specific. Name two or three motions or interactions that change the feel of the page.
- Make the `design tokens` semantic. Use roles such as background, surface, primary text, muted text, accent, display, headline, body, and caption.
- Make the `asset plan` honest. Call out what real content exists and what still needs to be invented.
- Make assumptions explicit instead of silently filling gaps.
