# Craft rubric — world-class floor + AI dead-void / wrong-proportion guards

Two uses: **Invent** → design to these as targets. **Critique** → audit a mockup against them.

## Read these two gates FIRST

**1. Surface type (declare one).** Composition rules below marked `‹cond›` are CONDITIONAL on this — applied
dogmatically they fail legitimate masters (Apple whitespace, Linear's flat dense scale, a uniform catalog).
- `marketing/editorial` — full composition drama (dominant focal, asymmetry, big type scale).
- `dashboard/data` — co-equal elements OK; require a clear entry point / scan-order, not one 40% hero.
- `tool/dense` — flat type scale (largest÷body ≥1.5) is correct; don't force display type.
- `minimal/luxury` — low density is a craft signal, not a void (density floor 0.20 if framed around a focal element).
- `app/utility` — pragmatic; states + a11y matter more than drama.

**2. Checkability (never fabricate precision).** Tag every finding by what you can actually verify:
- `[IMG]` verifiable from a static image (proportion, density, focal area, contrast by sampling, alignment, voids).
- `[DOM]` code/DOM only (exact 8px grid, rem/em, line-height numbers, `ch` measure, aspect-ratio CSS, tabular-nums).
- `[LIVE]` live-render only (zoom reflow, hover/focus states, motion, CLS).
Auditing a PNG you can honestly confirm only `[IMG]` (~60%). For `[DOM]`/`[LIVE]`, say "needs code/live check" —
do not invent numbers. (This project has a fabrication history; this rule is non-negotiable.)

---

## A. Spatial system (the #1 source of AI slop)
- **A1 `[DOM]` 8px grid.** All spacing on the additive scale `4·8·12·16·24·32·48·64·96`; ≥90% divisible by 8
  (4px only for icon/type optical nudges). Ban odd/prime values (7, 11, 13, 23).
- **A2 `[IMG]` Internal ≤ External.** Padding inside a component < gap between components < gap between sections.
  Section gap ≥ 1.5× the largest in-component padding (24 padding → ≥36 section gap).
- **A3 `[IMG]` Section rhythm.** One repeating spacing pattern; break it only for a single deliberate emphasis.
- **A4 `[DOM]` Responsive spacing scales non-linearly:** ×0.75 ≤768px, ×0.5–0.625 ≤480px (32→24→16); use `clamp()`.
- **A5 `[IMG]` ‹cond› Density** (content px ÷ viewport px) = 0.40–0.60. <0.35 = sparse, >0.75 = cramped. *Exempt for
  `minimal/luxury` down to 0.20 IF the emptiness is symmetric/framed around a focal element (structured, not orphan).*

> **Type vs spacing — resolve the contradiction:** type may use a modular ratio (below); **spacing uses the 8px
> additive scale, NOT a geometric ratio.** Do not force them onto one shared ratio (8×1.25=10→12.5 is off-grid).

## B. Proportion & composition
- **B1 `[DOM]` Modular scale (sizes/type):** size = base × ratio^n, ratio ∈ {1.2, 1.25, 1.333, 1.5, 1.618}, ±5%;
  consecutive sizes cluster on ONE ratio.
- **B2 `[IMG]` ‹cond› Focal point** (`marketing/editorial`): exactly one element ≥40% above-fold AND ≥2.5× the next.
  For `dashboard/grid/gallery`: require a clear entry point / scan-order instead.
- **B3 `[IMG]` Aspect ratio:** every image/card/hero holds an **intentional, named ratio consistently across
  siblings** (e.g. 1:1, 3:2, 16:9, 16:10, 2:1, **golden 1.618, portrait 4:5/3:4/9:16**). The failure is
  undefined/stretch-to-fill, not "a ratio off a fixed list."
- **B4 `[IMG]` Hero band** 40–55% above-fold, paired with ≥2 content rows so it never floats alone.
- **B5 `[IMG]` ‹cond› Asymmetry — default, with exemption.** Prefer 60/40 or 62/38 over 50/50. BUT symmetry is
  valid when it's the deliberate concept (centered hero — Stripe/Linear/Vercel, balanced pricing tiers, editorial).
  **Symmetry alone is never the fail; symmetry + emptiness + no focal point is.**
- **B6 `[IMG]` Optical correction:** ±5–15% manual nudges (circles/triangles +7–10% vs squares, ALL-CAPS −10%
  tracking, icon optical-centering). Mathematically centered ≠ optically centered.

## C. Typography
- **C1 `[DOM]` ‹cond› Type scale:** ≥4 roles (Display/Headline/Title/Body/Label). Expressive surfaces: largest÷body
  ≥2.5–3.0. **Dense/data/tool: ≥1.5 is correct** — don't force display type. Body 16px (min 14).
- **C2 `[DOM]` Line-height:** body 1.5–1.65; headings scale **inversely** (display 1.05–1.1 → small 1.3).
- **C3 `[DOM]` Measure** 45–75 char (66ch target; hard cap 80; CJK ≤40). `max-width: 66ch`.
- **C4 `[IMG]` Hierarchy = 3 signals, never size alone:** size differs ≥10%, weight jumps ≥100 (400→600), luminance
  differs ≥40. Max 2–3 weights, max 2–3 families.
- **C5 `[DOM]` Tracking:** ALL-CAPS +0.05–0.12em; ≤12px text +0.02–0.05em; body 0.
- **C6 `[DOM]` Tabular figures** in tables/prices.

## D. Color & identity
- **D1 `[IMG]` Contrast (WCAG):** body ≥4.5:1; large (≥18.66px / bold ≥14pt) ≥3:1; UI/icons/focus/chart strokes
  ≥3:1 — per state (default/hover/focus/active) in BOTH light and dark.
- **D2 `[IMG]` 60-30-10:** dominant/neutral 60, secondary 30, accent ≤12%.
- **D3 `[DOM]` One deliberate accent + fixed semantic set** (error red, success green, warning amber, info blue) —
  never swap meanings; use role tokens, not scattered hex.
- **D4 `[IMG]` Neutral ramp** 8–10 grays, near-black (not #000) → near-white (not #FFF); bg saturation ≤10%.
- **D5 `[IMG]` Target the AI cliché CLUSTER, not the hue.** Fail only the unearned default combo appearing
  *together*: Tailwind indigo-500/600 as sole accent + violet→cyan diagonal gradient + Inter + rounded-2xl. A
  deliberately chosen purple with a custom ramp and a reason PASSES. Saturation cap ~80% (no neon unless ≥5:1);
  max 1 gradient, ≤2 stops, contrast-tested.
- **D6 `[IMG]` Grayscale test:** desaturate → hierarchy must survive (value, not hue); never convey state by color
  alone (add icon/label). Colorblind-safe.

## E. Effects, icons, alignment
- **E1 `[IMG]` Max 1 effect per element** (shadow OR gradient OR blur, not stacked); single shadow; glass contrast
  holds after blur (≤12px).
- **E2 `[IMG]` No emoji** in nav/CTA/functional UI — SVG icons at explicit 24–48px.
- **E3 `[DOM]` Whole-integer positions** (no 0.5/1.7px → blur); flex/grid centering, not manual margins.

## F. Accessibility / responsive / zoom
- **F1 `[IMG]` Touch targets ≥44×44px** (48–56 mobile); ≥8px between controls (16 ideal); safe-area ≥16px mobile /
  32px desktop margin.
- **F2 `[LIVE]` No overflow at 100/125/150/200% zoom;** rem/em units, **min-height (never fixed max-height) on text
  containers**; CLS ≤0.1.
- **F3 `[LIVE]` Breakpoints 375 / 768 / 1024 / 1440** (include 1024 — most reflow voids appear at tablet-landscape);
  ratios persist ±5%; mobile font ≥14px, shrink ≤30%.

## G. Motion `[LIVE]` (the static rubric is blind to this — louder AI-tell than gradients now)
Max 1–2 easing curves; durations 150–250ms (UI feedback) / 200–400ms (entrances); stagger only purposeful lists;
**always honor `prefers-reduced-motion`**; no decorative infinite animation on functional controls; no
fade-in-everything-on-scroll, no `scale(1.05)` hover on every card, no parallax-for-no-reason.

## H. Content integrity `[IMG]`
No `lorem ipsum` / "Your X here" / placeholder shipped as final; no templated value-prop triplet ("Streamline /
Unlock / Powerful"); no fake metrics ("10,000+ happy customers") unless real and labeled; no emoji in headings.

## I. State coverage `[IMG]` (AI ships only the happy, full state)
Every data surface defines **empty / loading / error / overflow** (long string, many rows, 0/1/many). Inputs look
distinct from buttons and from static text; labels persist (no placeholder-as-label).

## J. Dark mode `[IMG]`
Canvas not pure #000 (use ~#121212–#0F172A); elevation = lighter surface tint (+4–8% white/level), **not** drop
shadow; accent lower saturation / higher contrast on dark; the SAME hierarchy order survives the light→dark swap.

---

## AI dead-void guards (detect → fix)
- **Dead-center island `[IMG]`** — element centered with >50px gap to all 4 edges, <50% width used, blank around it.
  → break to 60/40 or 62/38, anchor to ≥2 sides/grid, add supporting content. (Exempt: a deliberate centered hero
  that still passes focal + has vertical rhythm.)
- **Region void `[IMG]`** — region <20% content-area AND >40% viewport-height, no rhythm/purpose. → distribute,
  anchor footer via flex `space-between`, reduce height, or add intentional pattern.
- **Column-fill failure `[IMG]`** — tallest content <75% of a fixed-height column, >25% empty bottom. → drop fixed
  height, `min-height` + flex, distribute, or pin footer.
- **Column-balance void `[IMG]`** (geometry misses this) — in a multi-column row, the short column's content height
  <60% of the tall column (and not declared masonry). → balance content or use masonry.
- **Trapped gap `[IMG]`** — a single inter-element vertical gap >3× the section-rhythm unit that isn't a declared
  section break. → close to rhythm or make it an intentional section.
- **Wrap-orphan `[LIVE]`** — N items wrap so the last row is a lone item flanked by empty cells (5 cards → 2+2+1
  centered). → justify-fill/stretch the grid or pad to a full last row; test at 1024px.
- **Stretch-to-fill `[IMG]`** — image/card/hero with undefined w÷h sized to the space. → lock an intentional ratio.

## Wrong-proportion / hierarchy guards
- **Arbitrary spacing `[DOM]`** — off-grid (7/11/23px) or random jumps. → snap to 4/8 multiples.
- **Flat hierarchy `[IMG]`** — ≤3 type sizes, largest÷body below the surface-type floor, or size-only hierarchy.
  → add roles + weight/color signals; (expressive surfaces only) one focal ≥2.5× secondary.
- **Hollow/inverted weight `[IMG]`** — large pale element outweighed by a small dark button (fails grayscale).
  → fix value hierarchy.

## Force-variation → **justify sameness** (do NOT manufacture noise)
Uniform card grids / standard SaaS section orders are CORRECT when content is genuinely homogeneous (catalog,
table, equal options) — that's a feature, not slop. The fail is sameness used to **hide a void** or a layout with
**no focal hierarchy**. **Variation must map to content importance, never be cosmetic.** Do not mandate "featured
card every 4th" or "40% must vary" — those produce the try-hard look that itself reads as AI.

---
Sources: Refactoring UI · Material 3 (type scale, color roles, 8dp) · Apple HIG · WCAG 2.1/2.2 (1.4.3, 1.4.11,
1.4.12, 2.5.5) · Modular Scale / Tim Brown · Baymard (line length) · Butterick / Typography Handbook · EightShapes
"Space in Design Systems" · 60-30-10 / WebAIM · Adrian Roselli (responsive type & zoom) · Dieter Rams · Müller-
Brockmann (Swiss grid).
