# Production Handoff

## Translate The Visual Thesis

Before coding, map each visible region to:

- semantic purpose;
- source data;
- mutations and side effects;
- interaction states;
- accessibility behavior;
- responsive behavior;
- loading and failure behavior.

Do not reproduce mockup pixels blindly. Preserve the information hierarchy and behavior.

## Artifact Implementation

Use code-native HTML, CSS, SVG, Canvas, or WebGL when the artifact responds to live data.

Choose the simplest medium that preserves:

- crisp rendering at all sizes;
- accessible labels and focus;
- deterministic state changes;
- reduced-motion behavior;
- acceptable CPU, GPU, memory, and bundle cost.

Use raster generation for static textures, illustrations, or materials only. Never bake live labels, status, progress, or actions into a bitmap.

## State Matrix

Define before implementation:

| State | Required behavior |
|---|---|
| Loading | Preserve layout, avoid false empty-state claims, show progress honestly |
| Empty | Explain value and expose one clear creation action |
| Typical | Optimize the three-second contract |
| Dense | Compress secondary information without hiding primary actions |
| Error | Preserve surrounding context, identify failed region, provide retry |
| Stale | Mark freshness without alarming the user |
| Permission | Explain missing capability and path to resolution |
| Offline | Preserve readable cached state where possible |
| Reduced motion | Keep meaning through immediate state and material changes |

## Responsive Recomposition

Do not shrink desktop.

- Preserve the three-second contract.
- Convert wide relationships into ordered disclosure.
- Keep the primary action reachable.
- Replace hover-only behavior.
- Avoid nested scrolling and clipped fixed-height canvases.
- Test real long labels at narrow widths.

## Motion Contract

Every animation must answer one of:

- what changed;
- where an object went;
- what is selected;
- what is loading;
- what action succeeded.

Prefer transforms and opacity. Avoid constant ambient motion competing with work. Use smooth state continuity rather than swapping rendered images.

## Functional Preservation

Inventory existing controls, routes, mutations, keyboard behavior, analytics, and permission rules before replacing UI. Preserve them unless removal is explicitly authorized.

If a function feels unnecessary, determine whether the problem is capability, placement, frequency, or naming before deleting it.

## Verification

Verify:

- exact data and mutation behavior;
- keyboard and focus order;
- semantic headings and labels;
- color contrast;
- typical, empty, dense, loading, error, and long-content states;
- mobile and desktop layouts;
- reduced motion;
- no console errors;
- no unnecessary polling or hidden mounted panels;
- bundle and rendering cost proportional to the feature.

Finish with evidence: screenshots, interaction checks, test results, and measured performance where relevant.
