---
name: warcry
description: >-
  Convene an agent army to investigate, debate, and FORGE a bulletproof plan for a NEW feature — the
  generative counterpart to /bulletproof (which only reviews a plan that already exists). Use when the user
  says "/warcry", "sound the warcry", "convene the army", "think together about a plan", or asks to design/plan
  a new feature from a rough idea by spawning multiple agents to research and pressure-test it. The orchestrator
  frames the mission, fans out read-only specialist scouts in parallel, synthesizes distinct candidate
  approaches, runs a judge/adversarial panel to pick one, authors the plan, then hands it to the `bulletproof`
  reviewer to validate. It produces a reviewed PLAN ONLY and does NOT implement — building the plan is a
  separate, explicit step (`/katana`). Works with or without a repo; scales from a 3-scout sweep to a full
  exhaustive army.
---

# Warcry — convene an agent army to forge a bulletproof feature plan (manual)

Run when the user says `/warcry` / "sound the warcry" / "convene the army" / "think together about a plan" —
typically with nothing but a rough feature idea. This is the GENERATIVE twin of `bulletproof`: bulletproof
*reviews* an existing plan; warcry *builds* one with an agent army, then ends by calling bulletproof on the
result. MANUAL skill — does not auto-fire.

**The army is only as sharp as the mission you give it.** A vague frame produces six agents writing generic
essays. Phase 0 is what makes the rest worth the tokens — do not skip it.

## Phase 0 — Frame the mission (orchestrator, inline, before spawning anyone)
Write a tight mission brief. This is the shared context every scout and judge receives verbatim.
- **Anchor to the user's VERBATIM ask.** Quote what they actually said; do not let your paraphrase become the
  goal. If your one-line framing drifts from their words, confirm it before spending the army — a misframed
  mission aims the whole army wrong, and bulletproof then only checks the plan against your framing, not their
  ask. (Borrowed from `/eagleye`: don't trust your own restatement of the goal.)
- **The feature in 1–2 lines** — the job-to-be-done, who it's for, and the one observable signal that means
  it worked. Not a feature list; the *outcome*.
- **Context / deployment model** — what does this plug into and what actually runs it? (packaged app / hosted
  service / library / CLI / cron / greenfield idea with no repo?) This bounds which approaches and failure
  classes are even possible — borrowed straight from `bulletproof`. If in a repo, name it; if not, say so and
  the army works from the idea + prior art.
- **Load-bearing assumptions (2–3)** — state them as assumptions, not facts, so the scouts can confirm or break them.
- **Success criteria + guardrails** — what the final plan MUST satisfy (the yardstick the debate scores
  against), and what is explicitly OUT of scope.
- **Completeness-class check (∀-shaped / sweep features).** Ask: is the job "do X to **ALL** Y"? — translate /
  i18n the UI, rename a symbol everywhere, migrate every call site, theme / RTL / a11y-sweep every component,
  bulk-replace, delete-all-usages. Its success shape is **∀, not ∃**, and the normal "phase the long tail" /
  "ship 80%" defaults will leak. For these:
  - The success criterion is **100% of the enumerated population — zero leaks.** "Partial / phased coverage is
    fine" is **BANNED from Out-of-scope.** You may phase *risk* or *depth*; never *coverage of the in-scope
    population*. (A half-translated UI isn't a smaller feature — it's a broken one.)
  - Require a scout (the cartographer, or a dedicated inventory pass) to produce the **exhaustive,
    machine-checkable INVENTORY** of the population — every string / call site / component — **plus the command
    that regenerates and checks it** (e.g. the grep that lists every user-facing literal, every route). An
    **estimate ("~200–400 strings") is rejected**; enumeration is the deliverable.
  - A pre-mortem "partial / leaks-through" finding maps to **"enumerate + a coverage gate"**, NEVER to "a
    fallback is fine" — do not conflate an intentional *safe fallback* (e.g. show English for untrusted content)
    with *accidental un-done work* just because they look the same on screen. bulletproof must FAIL a sweep plan
    that has no coverage gate or no inventory.
- **One clarifying round, only if the shape genuinely forks.** If a single unknown changes the entire plan
  (e.g. "real-time vs batch?", "who's the user?"), ask it once via AskUserQuestion before spending the army.
  Otherwise state the assumption and proceed — do not poll.

## Phase 1 — Deploy the investigators (parallel fan-out, READ-ONLY)
Spawn the scouts as `Explore` agents (read-only → parallel-safe, no file conflicts) **in a single message
with multiple Agent calls** so they run concurrently. Give each the Phase-0 brief + its lens + the return
schema. Pick the lenses that fit — running a lens with nothing to find is noise, not thoroughness.

| Scout | Lens | Skip when |
|---|---|---|
| **Prior-art scout** | How is this solved elsewhere — patterns, libraries, reference designs, known pitfalls (web + memory). | almost never |
| **Codebase cartographer** | Integration points, conventions, what it touches, blast radius, constraints. For a **sweep/∀ feature, ENUMERATE the full population** (every literal / call site / component) + the command that lists it — never sample or estimate. | greenfield / no repo |
| **Feasibility & constraints** | Runtime / scale / platform limits, cost, latency, the "what do you actually run" bound. | trivial UI-only change |
| **Pre-mortem analyst** | Assume it shipped and failed — enumerate failure classes, edge cases, boring ops risks. | never (this is the highest-value scout) |
| **User & workflow** | Jobs-to-be-done, the surfaces, the unhappy paths, what "good" feels like. | pure infra/internal |
| **Data / integration / state** | Schema, migrations, external systems, idempotency, consistency. | stateless feature |

Each scout returns a **tight brief, not an essay** — enforce this schema:
- `FINDINGS` — 3–6 signal bullets.
- `CONSTRAINTS` — the 1–2 things that most shape the design.
- `OPEN QUESTIONS` — unknowns that would change the plan.
- `SOURCES` — for prior-art/web (so claims are checkable).

## Phase 2 — Synthesize the intel (orchestrator, inline)
Merge the briefs, de-dupe, and surface the real **tensions/tradeoffs** (where scouts disagree is where the
design decision lives). Produce **2–3 genuinely DISTINCT candidate approaches** — different bets, not three
shades of one. Each: its core bet, its strengths, its top risk, and which findings it leans on. If one
approach is the clear obvious winner, say so and skip straight to Phase 4 — do not manufacture rivals.

## Phase 3 — Think together: the debate panel (parallel)
This is the "investigate and think together" the user asked for. Spawn judges concurrently (read-only `Plan`
or `general-purpose` agents), each scoring all candidates against the Phase-0 success criteria + risk, and
returning a ranked verdict **with reasoning**:
- **Default:** 1 synthesis + a 3-judge panel.
- **Close call:** add a champion + skeptic per leading approach (one argues it's the best, one tries to break
  it) so the decision survives the strongest objection.
Then the orchestrator picks the winner and **grafts the best ideas from the runners-up**. Record the killed
approaches and *why* — that reasoning goes in the plan so it isn't relitigated later.

## Phase 4 — Author the plan
Write the plan so `bulletproof` can consume it: **Goal / Approach (+ why, + rejected alternatives) / Phased
steps / Files & surfaces touched (if repo) / Data & schema changes / Test & verification strategy / Rollout
& rollback / Risks → mitigations / Out of scope / Success criteria restated.**

## Phase 5 — Bulletproof it (composition — this is the hand-off)
Invoke the **`bulletproof`** skill on the drafted plan. It spawns the read-only `plan-reviewer` (opus) →
returns a coverage table + top gaps + **VERDICT: SUFFICIENT / INSUFFICIENT + must-haves**.
- INSUFFICIENT → revise the plan against the must-haves and re-run. **Cap at 3 rounds.**
- Still insufficient after 3 → surface the outstanding gaps and let the user decide. Never silently pass.

## Phase 6 — Deliver
Stamp the plan: `> Forged in /warcry · Reviewed ✓ (bulletproof) — <one-line verdict>`. Present it. If it
lives in a repo, offer to drop it as a plan doc (e.g. `docs/PLAN_<feature>.md`). If the war council diagnosed
a generalizable failure class worth remembering, log it per bulletproof's INCIDENTS discipline.

## Scaling dial — match the army to the ask
- **Quick** ("plan this small feature"): 3 scouts (prior-art, pre-mortem, + the one domain lens that matters),
  1 synthesis, single-judge pick, bulletproof once.
- **Standard:** full relevant roster, 3-judge panel, bulletproof loop.
- **Exhaustive** ("be thorough / leave nothing"): full roster + champion/skeptic debate + a completeness
  critic ("what lens didn't we run, what claim is unverified?") + loop-until-no-new-risks before bulletproof.
- **Heavy deterministic fan-out (50+ agents, staged):** the `Workflow` tool runs this army as a scripted
  pipeline with cached resume. It requires the user's **explicit opt-in** (they say "use a workflow" /
  "ultracode") — offer it for large jobs; do not default to it.

## Speed discipline — the army must NET-SAVE time
The army exists to reach a *better plan faster*, not to add ceremony.
- Spawn scouts in ONE message (true parallel), never sequentially. Cap concurrency ~4-5 — more agents contend
  on I/O and stop helping.
- Run the SMALLEST roster that covers the real lenses; a scout with nothing to find is pure latency, not rigor.
- For a small or clear-cut feature, a quick inline plan + a single `/bulletproof` beats convening the full
  army. If fan-out won't clearly beat thinking it through directly, skip the army.

## Anti-noise discipline (mirrors bulletproof's anti-overfit rule)
- Briefs are signal, not essays — kill any scout lens with nothing real to find.
- The debate must be grounded in the scouts' findings, not vibes; a judge with no evidence doesn't get a vote.
- Don't invent extra approaches or objections to look thorough. A clear winner is a feature, not a failure.
- Scouts are READ-ONLY. They investigate and report; they never edit. Only the orchestrator writes the plan.

## Note
`warcry` (forge the plan) and `bulletproof` (review) are designed to chain — warcry always ends inside
bulletproof, so a plan is never delivered unreviewed. warcry produces a PLAN ONLY; building it is `/katana`. Default agents: `Explore` for scouts, `Plan`/`general-purpose` for
judges, `plan-reviewer` (via `bulletproof`) for the gate — **no new agent files required**. If you later want
named, pinned scout agents, add them under `~/.claude/agents/` mirroring `plan-reviewer.md`.
