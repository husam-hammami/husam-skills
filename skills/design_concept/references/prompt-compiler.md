# Mockup Prompt Compiler

## Principle

An image model needs a strong thesis and hierarchy, not an implementation specification.

The first prompt should generate one excellent screen that proves the concept. Add responsive states, assets, and documentation only after approval.

## Prompt Order

1. **Task**: one screen, dimensions, product and screen.
2. **Concept thesis**: one paragraph describing the functional idea.
3. **Dominant artifact**: appearance, meaning, and state behavior.
4. **Three-second hierarchy**: first, second, and third reads.
5. **Composition**: broad regions and negative space.
6. **Fixture content**: only enough real data to prove the design.
7. **Craft direction**: material, typography, depth, density, and mood.
8. **Reference contract**: what to emulate and what not to copy.
9. **Hard exclusions**: five to ten likely failure patterns.
10. **Output constraint**: one final mockup, no alternatives or explanation.

## Length And Specificity

Target roughly 250 to 600 words.

Include:

- one visual thesis;
- one signature interaction;
- one primary action;
- five to eight realistic facts;
- the minimum navigation needed for context.

Avoid:

- nine-artboard requests;
- exhaustive token tables;
- implementation details invisible in the image;
- long acceptance checklists;
- competing metaphors;
- repeated adjectives;
- exact coordinates for every element.

## Reference Handling

Attach the fewest references possible.

Label each:

- `product truth`: current navigation, content, or brand;
- `craft benchmark`: quality only;
- `anti-reference`: a failed direction that must not be remixed.

Prefer omitting failed images. Negative visual references often anchor generation toward the failure.

## Prompt Template

```text
Create one polished [dimensions] mockup for [product]'s [screen].

CONCEPT: [name]

[Functional thesis in 2-4 sentences.]

The dominant artifact is [artifact]. It communicates [data mapping] and supports [primary action]. It is not decorative.

The screen must communicate immediately:
1. [first read]
2. [second read]
3. [third read]

COMPOSITION
[Broad composition and responsive or platform context.]

CONTENT
[Minimal realistic fixture content.]

CRAFT
[Material, typography, atmosphere, restraint.]

REFERENCE CONTRACT
Use attached [reference] only for [qualities]. Do not copy [composition/metaphor/silhouette].

AVOID
[Likely failure patterns.]

Silently explore alternatives, then render only the strongest final screen. No variants, annotations, or implementation documentation.
```

## Final Check

Delete any instruction that does not visibly improve the first mockup. If the prompt reads like a product requirements document, shorten it.
