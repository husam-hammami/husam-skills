---
name: katana
description: >-
  Execute an already-approved, bulletproofed implementation plan with an agent army — surgically and FAST.
  The build/execution twin of /warcry (forge the plan) and /bulletproof (pass it): warcry plans, bulletproof
  reviews, katana builds. Use when the user says "/katana", "execute the plan", "build the plan", "implement
  this with the army", or hands over a plan stamped VERDICT: SUFFICIENT. Slices the plan into disjoint
  work-cards, runs them in parallel on isolated git worktrees, integrates them in dependency order through a
  deterministic verify gate, and reports — without corrupting the tree, shipping a broken build, or
  over-reaching beyond the plan. Right-sizes the army so parallelism NET-SAVES wall-clock and collapses to a
  serial/inline path when orchestration wouldn't pay for itself. Works with or without a repo; never pushes
  or deploys. Architecture chosen by a 10-agent design army (recon → judge panel → adversarial critic).
---

# Katana — execute a bulletproofed plan with a surgical, fast agent army (manual)

Run when the user says `/katana` / "execute the plan" / "build the plan" / "implement this with the army".
katana is the BUILD leg of the family: **/warcry (plan) → /bulletproof (review) → /katana (build)**. It
*executes* an approved plan; it does not plan, relitigate, or auto-fix. MANUAL skill.

## Phase 0 — Gate & right-size (BEFORE spawning anything)
**Hand-off gate.** Refuse to run unless the plan is explicit and carries bulletproof's `VERDICT: SUFFICIENT`
stamp (the output of `/warcry → /bulletproof`). No stamp → offer to run `/bulletproof` first. katana never
re-validates or silently "improves" the plan, and never auto-fixes a failure — a red may mean the *approved
plan* was wrong, which is the user's call, out of scope.

**Right-size the army — it must NET-SAVE wall-clock, or don't convene it.** The army has real overhead:
worktree setup (~hundreds of ms + disk each), an optional serial contracts pass, and a serial per-merge verify
tail. Parallelism only wins when enough genuinely independent, non-trivial units exist to amortize that.
- **< ~3 independent units, or the whole plan is a handful of edits in one area → do it inline/serially.**
  No worktrees, no merge queue. The overhead would cost more than it saves.
- **Concurrency cap ~4-5.** Beyond that, parallel agent processes contend on I/O and the wall-clock win
  flattens — batch the rest, don't spawn 20 at once.
- Always pick the **lightest safe mechanism** and collapse the dial: army → serial → inline.
- Rule of thumb: if you can't say *why parallel beats serial for THIS plan*, run it serial.

## Phase 1 — Slice into cards + collision scan
Turn the plan into **work-cards**, one per agent. Each card carries:
- `id` + a 3-5 sentence INTENT — only this card's slice of the plan, never the whole plan.
- the exact FILE LIST it may touch (its scope boundary).
- READ-ONLY deps it may import but not edit.
- a **FORBIDDEN-VERB block**: do NOT refactor / extract / dedupe / inline / simplify / clean-up /
  remove-dead-code / optimize / rewrite / reorder anything outside the file list. "See a better abstraction?
  Leave a one-line comment — do NOT build it." This is the surgical contract: minimal diffs only.
- a per-file **STYLE-REFERENCE snippet**: 10-30 lines read from each target file (import grouping, error
  handling, naming, comment style) so new code matches house style and the diff isn't bloated with reformatting.

**Plan-time collision scan (hard precondition).** Before any agent spawns, intersect all cards' file lists.
Two cards claiming the same path are NOT parallel-safe → serialize them or merge them into one card. Catch the
collision before a byte is written, not at merge time.

## Phase 1.5 — Classify coupling → choose the mechanism
Find the shared contracts cards depend on: shared interfaces/signatures, types, schemas/migrations, and shared
**registry/barrel/index files** (`__init__.py`, `index.ts`, `mod.rs`, route tables), lockfiles, shared config.
These are the corruption surface.
- **No shared contracts, cards fully disjoint** → skip the contracts pass; go straight to parallel bodies.
- **Shared contracts exist** → run PASS 1 first. Don't pay that complexity when you haven't earned it.

## PASS 1 — Contracts first (only if shared contracts exist) — serial, ONE atomic commit
One agent (or you) materializes ALL shared surface in a single commit: signatures, type defs, schema, and every
registry/barrel registration the cards need. Bodies may be stubs. **Exit gate:** imports resolve, no cycles, no
runtime logic. This commit becomes the **read-only root** every body worktree branches from — so no body agent
re-touches a shared registry, and git can't cleanly merge two edits against a half-built contract. The shared /
registry / lockfile / config / type files are READ-ONLY for the rest of the run.

## PASS 2 — Parallel bodies — isolated, surgical
Spawn body agents (cap ~4-5 concurrent) each in its **own git worktree** rooted at the contracts commit
(`isolation: 'worktree'`), created OUTSIDE any cloud-synced folder. Each implements ONLY its card.
- **Fast checks only here:** compile / type-check the CHANGED files. NO full test suite, NO pipeline or
  integration runs, NO writes outside the worktree — keeps the parallel phase cheap and race-free.
- **Scope reject-gate (blocking):** `git diff --name-only` must be a subset of the card's file list — reject
  off-card edits. Diffstat threshold flag: "card said ~10 lines, diff is 80" → inspect before accepting.
- **No in-agent dependency installs** — parallel writes corrupt lockfiles; deps are a PASS 1 concern.
- **Fail-fast + thrash tripwire:** on the first card that can't satisfy its gate, cancel the rest rather than
  burn wall-clock. And if thrash signals fire — 2-3 consecutive card reds, a card ballooning past its scope, or
  the plan proving wrong mid-build — STOP and surface `/eagleye`: repeated failure usually means the *plan* is
  wrong, not the code, which is eagleye's call, not katana's (katana never auto-fixes or re-plans).

## PASS 3 — Topological merge + verify — serial, pinpointed
Integrate one card at a time, in dependency order (leaves first: new modules → consumers → entrypoints).
Cherry-pick each onto the working branch as a single commit, then run a FAST, DETERMINISTIC per-merge gate:
import-resolution smoke + the targeted tests for what changed. **Deterministic gates only — never an LLM
"looks right" judgement.**
- First red **halts** the queue, names the offending card with its failing output, and leaves the branch at the
  last green commit. **Single-commit rollback;** katana never auto-fixes.
- After all cards land: **ONE** whole-tree verify (full suite if it exists; else build/typecheck/smoke).

## Verify & review policy (adaptive)
- **Verify is mandatory; its FORM adapts.** Suite → run it. No suite → build / typecheck / lint / import-smoke.
  None of those → diff-sanity + an explicit "no automated verification available; needs a human check." Never
  silently skipped. Reuse `/verify` or `/health` — don't reinvent the gate.
- **Completeness gate (∀-shaped / sweep features) — mandatory, NOT sampled.** When the plan is "do X to **ALL**
  Y" (i18n / translate, rename-all, migrate-every-callsite, theme / RTL / a11y sweep, bulk-replace), verify =
  run the plan's **deterministic enumeration over the WHOLE population** and assert the property for EVERY item
  — grep every literal for the un-done state, visit EVERY route/screen, diff the call-site list to zero. **A
  handful of screenshots, a spot check, or "I audited the main screens" do NOT satisfy a ∀-verify — an audit
  that samples cannot prove coverage.** If the plan ships no inventory / no enumeration command, that's a plan
  gap, not something to paper over with sampling: STOP and surface it (the plan failed warcry's completeness
  rule), don't sample-and-ship. The leak you didn't enumerate is the one the user finds first.
- **Review is scaled, on by default for non-trivial work, explicitly waivable.** Multi-card or core/shared code
  → an independent read before hand-off via `/code-review` or `/codex`. Trivial single-card mechanical change →
  the verify gate is enough; *say* you skipped review.

## Deliver
katana ends at **locally committed + verified**. Report: cards landed, per-card diffstat, deferred/blocked cards
and why, verify + review results. It does NOT push or deploy — hand to `/ship` → `/land-and-deploy`.

## Hard safety rules (non-negotiable — generalized failure classes)
- **Single-shared-writer.** If an artifact is written by >1 module, one shared gate/function writes it, called
  LAST before any consumer; no body card adds a new write site for it. (Stops a parallel card re-emitting an
  artifact without a gate another card just added — an ordering defect worktree isolation does NOT catch.)
- **Read-only shared surface during bodies:** registries / barrels / index files, lockfiles, schema, shared
  config, shared types — written only in PASS 1.
- **Run from a real terminal, not nested inside another agent session** — nested headless runtimes can deadlock.
  If only nested execution is available, fall back to serial-with-checkpoints.
- **Worktrees off cloud-synced paths;** atomic writes (temp-then-move) for any produced artifact.

## Scaling dial
- **Inline** (<3 units / trivial): implement serially, verify once. The default for small plans — the army is
  opt-in, not automatic.
- **Standard** (disjoint cards, no shared contracts): parallel bodies (cap 4-5) → topological merge+verify.
- **Full hybrid** (shared contracts present): PASS 1 contracts → parallel bodies → topological merge+verify +
  independent review.
- **Heavy deterministic fan-out** (very large plans): the `Workflow` tool runs PASS 2/3 as a scripted,
  resumable pipeline — requires the user's **explicit opt-in**.

## Note
Family chain: **/warcry (forge plan) → /bulletproof (pass it) → /katana (build it)**, with **/eagleye** auditing
the trajectory if execution drifts. katana refuses a plan without the SUFFICIENT stamp, so unreviewed plans
never reach execution. It orchestrates and gates — it does not write code itself beyond the optional contracts
pass — and it reuses `/freeze` (scope-lock), `/verify` or `/health` (gate), `/code-review` or `/codex` (review),
`/ship` + `/land-and-deploy` (release) rather than reinventing them. The hybrid-collapsible architecture was
selected by a 10-agent design army: surgicality is a prompt+diff-gate property every candidate shares, so
write-safety and pinpointed verification are what decide — and the collapse-to-lighter rule keeps the army a
net speed win.
