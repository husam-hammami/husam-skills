# Motion Spec

A concept is not finished until its motion is specified. A design that is only impressive as a still image is rejected (see the invent rejection list). Motion is part of the concept, not a polish pass — so specify it with values an engineer can implement directly, with no new dependency.

## Specify motion in two registers

Every concept must name both:

1. **Continuous loops** — the always-on life of the surface (breathing glow, drift, twinkle, slow rotation, ambient pulse). These run forever, independent of interaction.
2. **Triggered moments** — the one-shot choreography that rewards an action (commit/ignite, enter/exit, open/dive, success flare). These fire once, on an event.

For each, give the **raw keyframe table + easing + duration**, not a vague adjective. "The orb breathes" is not a spec; "core opacity 0.3→0.8→0.3 over 4.6s ease-in-out" is. Handoffs should carry these tables so the build needs no animation library beyond what the project already has.

## Default implementation stack (prefer native; add no new library)

Before proposing a motion library, check what the project already depends on — a modern React animation library (e.g. framer-motion v12 / `motion`) is almost certainly present and is WAAPI-backed. The strongest, lowest-risk stack for a compositor-driven visual system is:

- **CSS `@keyframes`** for continuous loops — compositor-driven, zero JS, survives re-renders, cheap at many instances.
- **WAAPI `element.animate()`** for triggered one-shots — imperative, sequenced, no library; keyframe arrays + easing strings (this is what lets handoff specs be dependency-free).
- **The project's existing React animation lib** for declarative enter/exit, layout, and gesture.

Do not introduce a heavy timeline library (GSAP, etc.) unless the concept genuinely needs sequenced timeline scrubbing that the above cannot express — and say why. For most product UI, native WAAPI + CSS + the installed lib covers everything.

## Non-negotiable rules

- **Animate transform and opacity only.** Never animate `filter`/`blur`/`box-shadow`, and never scale or move a blurred/filtered layer — it forces a full GPU re-raster every frame, the most common source of jank/flicker. Put any moving transform on an unfiltered wrapper; keep the blur/filter on a static child.
- **Honor `prefers-reduced-motion`** for both registers: CSS via `@media (prefers-reduced-motion: reduce)`, JS via a `matchMedia` guard before `.animate()`. The reduced-motion state must still be legible and complete.
- **Motion encodes meaning, not decoration.** A loop or flare should reflect state or reward an action — never animate for spectacle that competes with the task.
- **Verify motion by sampling, never by a still.** Confirm continuous loops with computed-transform/opacity samples over time and triggered animations with the running-animation handle — a screenshot cannot tell "animating" from "frozen at frame 0".
