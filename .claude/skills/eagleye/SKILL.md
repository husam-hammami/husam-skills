---
name: eagleye
description: >-
  EXPLICIT INVOCATION ONLY — fires when the USER asks for a trajectory check: `/eagleye`, "zoom out",
  "are we in a rabbit hole", "are we on the right track", "step back", "are we lost". Do NOT self-invoke
  it because you suspect drift; if you think the session has gone sideways, say so in one line and let
  the user call it. Never run it on a schedule or reflexively — a recurring audit is its own rabbit hole.
  Objective mid-session trajectory audit — the circuit breaker for rabbit holes.
  It reconstructs the ORIGINAL objective from the first user messages,
  builds a neutral facts-and-quotes dossier (verbatim ask + raw git + failures + scope-adds), and has FRESH
  agents that did not do the work judge drift cold — returning a verdict (ON TRACK→CONTINUE / DRIFTING→CORRECT /
  LOST→RESET) with the gap, the fork where drift began, and the fastest correct path from here. The trajectory
  counterpart to /bulletproof (which reviews a PLAN); on RESET it hands to /checkpoint then /warcry. READ-ONLY
  and ADVISORY — it audits and recommends, never edits, decides, debugs, or re-plans. Project-agnostic, manual.
---

# Eagleye — objective mid-session trajectory audit (manual)

Run mid-session when the work may have drifted: `/eagleye` / "zoom out" / "are we in a rabbit hole" / "are we
on the right track" / "step back". eagleye is READ-ONLY and ADVISORY — it produces a verdict + correction and
hands off. It is the TRAJECTORY counterpart to `/bulletproof` (which reviews a plan).

**Core principle: the agent IN the hole must not judge itself.** Sunk cost + motivated reasoning mean the
worker will rationalize continuing. So the orchestrator's ONLY job is to mechanically EXTRACT a neutral dossier;
FRESH assessors who did not do the work read it cold, default to suspicion, and render the verdict. The
orchestrator is forbidden from writing any interpretation ("necessary groundwork", "we're close") into it.

## Phase 0 — Right-size & pick variant (~5s)
**Variant 0 — SNAP (the default first move, ~seconds, NO dossier).** Before building anything, give a plain
simple-perspective read: does the current work obviously serve the original ask, or are you obviously overthinking
/ over-engineering / chasing a tangent? Often it's visible in seconds — "step back, the simple path is X." Answer
and stop. **Overthinking is itself a drift signal**; eagleye is allowed to just say "this is simpler than you're
making it" without ceremony. Escalate to the dossier ONLY when the snap read is genuinely inconclusive.

Then, if escalating: gauge session depth (turns, time, git churn). Shallow / unclear → **Variant A** (single
skeptic). Deep multi-hour hole, scope exploded, RESET plausible, or "are we lost?" → **Variant B** (3-agent
panel). State the variant and why in one line. **Most zoom-outs should end in CONTINUE — a CONTINUE verdict is
a success, not a failure to find drift.** Do not pay panel ceremony on routine checks.

## Phase 1 — Anchor ground truth (mechanical, no spin)
Reconstruct the ORIGINAL objective from PRIMARY sources, not your memory:
- Pull the **first 2-3 USER messages VERBATIM** (via `mcp__ccd_session_mgmt__search_session_transcripts`,
  filtering for user messages, not tool results). Quote them; do NOT paraphrase — your paraphrase is the poison.
- The **assessor** derives the definition-of-done from those raw quotes. You do not pre-chew the goal.
- If no definition-of-done was ever stated, record `DoD: NONE STATED` — its absence is a finding, not something
  to invent.
- Cache the verbatim quotes as the **only yardstick**. (If the transcript tool is unavailable, say so and drop
  confidence — your in-context recollection is curated and less trustworthy.)

## Phase 2 — Build the neutral dossier (mechanical, complete-by-construction)
Facts and quotes only, sparsified by RULE (last-N-per-category), never curated by you:
- `ORIGINAL_ASK` — the verbatim first user messages.
- `DoD` — derived by the assessor, or `NONE STATED`.
- `GOAL_STATEMENTS_OVER_TIME` — every later restatement ("our goal is", "actually we need"), tagged by SOURCE
  (user vs agent). Presented as **drift evidence, never as the baseline**.
- `SCOPE_ADDS` — verbatim quote of every increment ("oh also", "let me first fix", "discovered we need"), each
  tagged **user-requested vs agent-initiative**.
- `FAILED_ATTEMPTS` — errors / test failures WITH COUNTS, and whether each led to a code change AND a *distinct
  new hypothesis*.
- `GIT_STATE` — raw `git log --oneline` since task start, `git diff`, `git status`, `git reflog`, revert count,
  and the file-churn map (same file repeatedly vs net-new). **Dump wholesale via commands — you may not choose
  which commits to include.** Include the extraction commands in the dossier so the user can re-run them.
- `CURRENT_FOCUS` — what the agent is doing in the last few turns + active files.
- `TRUNCATION_FLAG` — set if extraction was incomplete (>10% events missing, transcript too large, tool
  timeout). Batched per-category search is the fallback for huge transcripts.
- **EXCLUDED:** any interpretation, justification, sunk-cost framing, or pre-judged verdict.
Pretty-print the full dossier so omissions are visible to the user.

## Phase 3 — Fresh assessment (assessors read the dossier COLD)
- **Variant A:** one fresh-context in-session skeptic. **Label it a non-binding gut-check** — it may inherit
  lingering in-session framing, and it may NEVER issue a RESET on its own.
- **Variant B:** 3 read-only subagents in SEPARATE context, each with RAW git + transcript read access (not the
  dossier alone — so one can catch what the dossier omitted):
  - **Goal-Adjudicator** (read-backward): start from the DoD — "what must change for done?" → "does current
    focus deliver that?" — BEFORE reading the trajectory, to resist the "we're so close" sweep.
  - **Drift-Taxonomist**: score against the RED/AMBER/GREEN taxonomy below.
  - **Fork-Forensic**: find the single decision point where drift began, and compute reusability % + time-to-fix
    vs time-to-restart. Forbidden from sunk-cost framing.
Every assessor defaults to suspicion and puts the **burden of proof on any CONTINUE** (must cite diffs toward
the goal). Sunk-cost phrasing found in the transcript ("come this far", "too late to pivot") is AUTO-RED to
surface, not absorb.

## Phase 4 — Adjudicate & emit
Variant A → take the verdict (capped below RESET). Panel → **majority, with suspicion breaking ties toward the
worse bucket**, and a lone evidenced-RESET (reusability <20% + goal redefined) raising the floor to CORRECT.
Emit this fixed, fact-based structure:
1. **VERDICT** — one line with the numbers (gap trend, detour count, reusability %, status→action).
2. **GAP** — original goal vs current focus; distance in steps; reusability %; time invested vs time-to-goal.
3. **FORK** — @commit/timestamp: the decision quote, rationale type (user-requested | agent-initiative |
   valid-discovery | yak-shave), cost-so-far, recovery cost.
4. **CORRECTION** — the action (below).
5. **CONFIDENCE** — Strong (>80%) / Moderate / Low (<50% or `TRUNCATION_FLAG`) + a domain-caveat line.

## Phase 5 — Handoff (advisory; the user decides)
- **ON TRACK → CONTINUE** — proceed, and name an explicit scope boundary to hold ("finish X, then stop; do not
  start Y").
- **DRIFTING → CORRECT** — apply the tactical pivot: name what to KEEP (which commits), what to DROP (which
  scaffold), the next critical-path step, est. time. Not a re-exploration.
- **LOST → RESET** — recommend `/checkpoint` (capture the abandoned work) then `/warcry` pre-loaded with the
  re-anchored original goal. eagleye never resets, debugs, or re-plans itself.

## Verdict model — mechanically checkable entry criteria (default to the WORSE bucket on a tie)
- **CONTINUE** — detours ≤1 minor, reusability ≥95%, gap shrinking (diffs toward goal, not just activity),
  0 compounding red flags. "Making progress on *something*" ≠ CONTINUE.
- **CORRECT** — 1-2 detours, goal reachable in 3-5 steps, reusability 80-95%, fork-reversal + pivot cost <
  finishing the sidetrack (and < ~1-2h), no goal redefinition.
- **RESET** — 3+ forks OR goal reinterpreted/obscured, reusability <20%, time-to-restart < time-to-fix,
  complexity jumped 2+ tiers. Never RESET on a single red flag — escalate to CORRECT first.

## Signal taxonomy
- **RED (rabbit hole):** yak-shaving (3+ "fix X first"), thrash loop (same failure 3+ times / 3+ reverts of one
  file), whack-a-mole (fix A breaks B), silent agent-side scope creep, symptom-chasing, sunk-cost language.
- **AMBER (drift):** off-critical-path edge case, prompt-chasing, implicit priority flip.
- **GREEN (healthy):** scoped loop with a named exit, failure→root-cause→fixed-once, explicit user-aligned
  pivot, progress ratio >50%, agent can name when the task is done.

## Hard rules (the anti-self-deception kit — encode, do not soften)
1. **Judge against the cached VERBATIM original ask**, never the latest restatement. Later goal-statements are
   drift evidence, not the baseline. (Defeats goal-creep laundering.)
2. **Tag every scope-add by source.** Only agent-initiative counts as creep/sunk; user-requested adds REDEFINE
   the DoD (update the cached goal). Conflating them is the #1 false alarm.
3. **Measure gap as diffs-toward-the-goal + file-churn, never commit count.** Activity ≠ progress; high churn on
   one file while goal-files are untouched is RED whack-a-mole, not green progress.
4. **Reusability % has ONE definition:** "what survives a revert-and-restart-goal-first." Name the keep/drop
   commits. Default LOW when uncertain. `N/A` (not 0%) when there are no commits yet.
5. **Extraction is mechanical and complete-by-construction** — raw git dumps + the commands shown, rule-based
   sparsification, full dossier printed for audit. Omission is the poison "facts only" doesn't stop.
6. **`TRUNCATION_FLAG` forbids CONTINUE** — incomplete extraction floors at manual-review / Low confidence.
7. **Read-backward protocol is mandatory** (DoD → does current focus deliver it? → then trajectory); burden of
   proof on CONTINUE.
8. **Deep-dive exemption:** failure→*distinct new hypothesis* is GREEN investigation, not RED thrash. On a
   flagged specialist topic, confidence drops to Low and the verdict carries a domain-caveat — the user is the
   final appeal. (A legit calibration / ABI / compiler deep-dive can look like a hole to a domain-naive reader.)
9. **Absent DoD blocks CONTINUE** — emit "clarify DoD first" with a proposed reconstructed DoD; never fabricate
   a goal and judge against it.
10. **Variant A is a labeled gut-check, not objective**; RESET / high-stakes calls require Variant B.
11. **Anti-sunk-cost output rule:** never "you've invested Nh, so continue." Always frame as the fastest correct
    path FROM NOW ("Path A pivot = 1h; Path B continue-then-pivot = 4h; recommend A").
12. **Strict scope:** read-only, no edits/decisions. RESET → `/checkpoint` → `/warcry`; post-reset debugging →
    `/investigate`; re-planning → `/warcry`. eagleye does none of these itself.

## Speed discipline — the audit must SAVE time, not add ceremony
Default to Variant A; reserve the panel for deep, expensive holes. CONTINUE is the common, correct, successful
outcome — suspicion breaks *ties*, it does not manufacture drift where signals are GREEN. Don't let reflexive
`/eagleye` every 15 minutes become its own rabbit hole.

## Note
Family: **/warcry (plan) → /bulletproof (review plan) → /katana (build) — and /eagleye when execution may
have gone sideways.** eagleye audits the trajectory and, on RESET, kicks back to
`/checkpoint` then `/warcry`. It
reuses session-transcript + git as primary sources and hands off to `/investigate` (debug) and `/warcry`
(re-plan) rather than doing them. Architecture + the anti-self-deception rules were set by a 6-agent design
army (recon → design → adversarial critic): the critic's finding governs — without mechanical, complete,
audit-printed extraction and a verbatim-original-goal yardstick, an objectivity skill becomes a confident biased
rubber-stamp, the exact pathology it cures.
