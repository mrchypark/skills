# OpenAI GPT-5.4 Frontend Notes

Source: official OpenAI Developers blog post "Designing delightful frontends with GPT-5.4", reviewed on 2026-04-15.

## Core lessons

- Set explicit design constraints early. Good defaults include a single dominant headline, a limited section count, a small type system, and one main accent color.
- Ask for visual references. Screenshots, mood boards, reference products, and existing brand materials sharpen typography, spacing, image treatment, and composition.
- Treat the page as a narrative. Marketing surfaces usually need a clear sequence such as identity, support, detail, proof, and conversion.
- Define the design system early. Establish token roles for surfaces, text, accents, and typography before drifting into component sprawl.
- Prefer real content over placeholder content. Product context and believable copy help the model choose a better structure and tone.
- Be careful with motion and layered UI. Sticky, fixed, floating, and decorative elements must never collide with key content.
- Preserve existing systems when working inside a current product or brand.

## Strong taste defaults

- Start with composition, not a pile of components.
- Make the first screen feel like a poster or primary workspace, not a long document.
- Keep one dominant visual anchor in the first screen.
- Use cards only when containment is required for interaction or comprehension.
- Keep copy tight enough to scan quickly.
- Use whitespace, scale, alignment, crop, and contrast before adding extra UI chrome.
- Use motion sparingly and intentionally.

## Surface-specific guidance

### Landing pages

- Lead with brand or product identity first.
- Give the hero a single job and a single visual idea.
- Keep the text column narrow enough to read quickly.
- Avoid stuffing the first viewport with stats, promos, chips, and extra modules.
- Prefer full-bleed or clearly dominant visuals when the brief supports it.

### Product surfaces

- Organize the layout around primary workspace, navigation, and secondary context.
- Favor dense but readable information instead of decorative marketing treatments.
- Use utility copy for dashboards and tools. Headings should orient the operator immediately.
- Avoid card grids that break the workspace into too many framed islands.

## Engineering implications

- Use CSS variables or another token mechanism to encode the visual system early.
- Prefer familiar frontend stacks when no better local constraint exists.
- For straightforward frontends, faster and more focused iteration often beats excessive reasoning and overdesign.
- Validate the result on desktop and mobile before closing the task.
