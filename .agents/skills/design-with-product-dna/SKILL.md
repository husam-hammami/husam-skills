---
name: design-with-product-dna
description: >-
  EXPLICIT INVOCATION ONLY — fires when the user types `/design-with-product-dna` or asks by name for
  design work that must preserve an existing product's DNA. Do NOT auto-invoke it because a task involves
  a web app, dashboard, portal, component, or any UI surface — implement those directly.
  Invent, critique, refine, and implement distinctive premium UI/UX that preserves an existing product's
  design DNA without copying its screens or recycling prior concepts. Covers new or redesigned web apps,
  mobile apps, dashboards, portals, trackers, enterprise tools, consumer products, design systems, UI
  mockups, visual artifacts, interaction concepts, responsive states, motion direction, and production
  implementation when coherence and screen-level originality both matter.
---

# Design With Product DNA

Create interfaces that clearly belong to one product while giving every surface its own information model, artifact, composition, and interaction.

## Choose The Stage

Infer the stage from the request:

- `audit`: inspect product truth and identify design DNA, collisions, and UX failure.
- `invent`: produce and select a decision-complete concept.
- `mockup`: compile and render one strong screen.
- `critique`: diagnose an existing design or generated mockup.
- `refine`: protect the concept while correcting specific failures.
- `implement`: build an approved direction or a direction the user explicitly asked to implement.
- `full-loop`: audit, invent, mock up, critique, refine, implement, and verify when explicitly authorized.

For a design-only request, stop before code changes. For an explicit implementation request, lock the concept briefly, then implement without asking for redundant permission. Do not replace working behavior with a static mockup.

## 1. Ground In Product Truth

Inspect the actual product, repository, screenshots, live UI, design system, workflows, and data states before ideating.

Privately frame the moment:

> When [user] opens [surface] during [moment], they need to understand [truth] and confidently [action].

Define a three-second contract with no more than three answers:

1. What is true now?
2. What deserves attention?
3. What is the next useful action?

Inventory:

- required data and exact values;
- primary and secondary actions;
- navigation and platform conventions;
- current strengths worth preserving;
- current UX failures;
- empty, dense, loading, stale, error, permission, and offline states;
- responsive, accessibility, and reduced-motion constraints.

Never invent core features merely to make a mockup dramatic. Mark future concepts explicitly.

## 2. Separate DNA From Motifs

Read [references/dna-and-motif-ledger.md](references/dna-and-motif-ledger.md).

Build two lists:

- `Product DNA`: reusable qualities such as typography, contrast, material restraint, motion character, tone, spacing rhythm, icon behavior, and navigation conventions.
- `Motif ledger`: page-specific metaphors, silhouettes, artifacts, spatial grammars, and signature interactions already used.

Preserve DNA. Do not recycle motifs unless the repeated behavior is intentionally systemic and functionally identical.

A new surface must differ from neighboring surfaces on at least three of these axes:

- information model;
- dominant geometry;
- focal point;
- spatial grammar;
- signature interaction;
- time behavior;
- emotional posture.

Changing only color, copy, or decoration does not count.

## 3. Forge The Concept

Read [references/concept-forge.md](references/concept-forge.md).

Silently generate at least ten structurally different candidates. Vary the information model, artifact, composition, interaction, emotional posture, and behavior over time.

Require one proprietary functional artifact or behavior that:

- encodes real product data;
- supports the primary action;
- changes across real states;
- belongs to this product and surface;
- remains useful without glow, texture, or animation.

Reject candidates that are generic dashboards with decorative art, copied silhouettes, static-image tricks, metaphors that hide exact values, or concepts that fail under dense data.

Select one thesis. Do not average several ideas into a hybrid.

State the selected direction with:

- concept name and one-sentence thesis;
- three-second contract;
- functional artifact and data mapping;
- signature interaction;
- desktop and mobile composition;
- state behavior;
- why it belongs to the product but not to another page;
- primary risk.

## 4. Prove It Visually

For a mockup stage, generate one polished screen first. Use the fewest references necessary.

Label references as:

- `product truth`: content, navigation, brand, or behavior to preserve;
- `craft benchmark`: quality only;
- `anti-reference`: structural failure to avoid, preferably described rather than attached.

Prompt hierarchy:

1. screen and platform;
2. concept thesis;
3. functional artifact and data mapping;
4. three-second hierarchy;
5. composition;
6. minimal realistic fixture content;
7. craft and material direction;
8. reference contract;
9. exclusions;
10. one-screen output constraint.

Avoid asking the image model for multiple screens, responsive sets, asset packs, and implementation documentation in the first render.

## 5. Critique Without Losing The Idea

Classify the highest-level failure first:

- `concept failure`: wrong metaphor or decorative artifact;
- `composition failure`: sound idea, weak hierarchy;
- `rendering failure`: malformed geometry, text, material, or spacing;
- `reference-copy failure`: borrowed silhouette or interaction;
- `product-fidelity failure`: missing workflow, wrong data, or invented behavior;
- `system-DNA failure`: attractive screen that no longer belongs to the product.

Return `keep`, `refine`, or `reject`, followed by:

- `Works`: up to three strengths;
- `Fails`: highest-impact problems in priority order;
- `Preserve`: exact protected elements;
- `Remove`: exact elements that must disappear;
- `Change`: behavioral and compositional corrections.

After two failed refinements, return to concept invention.

## 6. Implement The Concept, Not The Screenshot

Read [references/production-handoff.md](references/production-handoff.md) before editing code.

Translate the concept into:

- semantic components and layout regions;
- existing data bindings and mutations;
- loading, empty, dense, error, and permission behavior;
- responsive composition changes;
- keyboard, focus, screen-reader, and contrast behavior;
- motion state machine and reduced-motion fallback;
- performance budget;
- reusable tokens versus page-local styling.

Build data-driven artifacts in code when they must change with state. Do not use a generated bitmap as a substitute for a dynamic control. Use generated raster assets only for genuinely static material, illustration, or texture.

Preserve all existing functional workflows unless the user explicitly removes them. Simplify visibility and hierarchy before deleting capability.

## 7. Verify At Real Density

Test at least:

- typical data;
- empty data;
- maximum expected density;
- long names and localization expansion;
- slow loading and failed requests;
- desktop and mobile;
- keyboard navigation;
- reduced motion;
- dark and light themes when supported.

Run the blur, logo-swap, motif-collision, functional-artifact, screenshot-trap, and product-reality tests from the references.

The final screen must answer the three-second contract faster than the old screen and remain useful after the visual novelty fades.

## Output Discipline

- Lead with the design decision.
- Keep one concept per iteration.
- Prefer exact product language over invented labels.
- Use premium restraint: fewer stronger elements, legible hierarchy, controlled material and motion.
- Never call a design original merely because it looks unusual.
- State what was preserved, what became page-specific, and what motif collisions were avoided.
- When implementation is authorized, finish with verification evidence rather than only a mockup.
