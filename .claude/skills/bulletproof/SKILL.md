---
name: bulletproof
description: >-
  Adversarially review ("bulletproof") an implementation plan before approving it. Use when the user says
  "bulletproof" / "bulletproof this plan" or invokes /bulletproof. Spawns the read-only `plan-reviewer`
  subagent (opus) to pressure-test the plan against the project's REAL failures (docs/INCIDENTS.md +
  live-session failures + code/git) and return SUFFICIENT / INSUFFICIENT + must-haves; revise until it holds.
---

# Bulletproof — adversarial plan review (manual)

Run when the user says "bulletproof this plan" / `/bulletproof` — ideally right before approving a
non-trivial plan. This is a MANUAL skill: it does not auto-fire and it cannot block anything.

**Right-size — the review must SAVE rework, not add ceremony.** The reviewer is a single agent; never spawn
more. For a trivial or low-risk plan, a quick inline sanity check is enough — reserve the full reviewer for
non-trivial plans where a missed gap is costly.

## 1. Gather grounding (this is what makes the review sharp, not generic)
- **Deployment model — what does the user ACTUALLY run?** (packaged EXE / hosted server / importable lib / cron job?)
  This scopes which failure classes are even possible. A class the artifact structurally eliminates is N/A, and
  hardening against it is over-engineering, not a gap. (Real example: "dependency drift" is moot under a frozen EXE
  — the libs are baked in; the user never has pip. Don't size a dev-env safeguard as a release blocker.)
- **Live-session failures** — summarize what has actually gone wrong / risks surfaced in this session.
- **Incident log** — read `docs/INCIDENTS.md` (or `INCIDENTS.md`) if present.
- **Project memory** + `git log --oneline -15`.
If there's no real history, say so — the reviewer falls back to a general failure-class checklist.

## 2. Run the reviewer
Spawn the **`plan-reviewer`** subagent (read-only, opus) with: the PLAN, the grounding, and repo read
access. It returns a coverage table, top gaps (biggest first), approach notes, regressions, and a
**VERDICT: SUFFICIENT / INSUFFICIENT + must-haves**.

## 3. Revise → re-review (capped)
- **INSUFFICIENT** → revise the plan to address the must-haves, then re-run the reviewer. Cap at 3 rounds.
- If still insufficient after 3, surface the outstanding gaps and let the user decide — never silently pass.

## 4. Stamp + proceed
When **SUFFICIENT**, note it on the plan (`> Reviewed ✓ (bulletproof) — <one-line verdict>`) and proceed
to approval.

## 5. Logging discipline (keep INCIDENTS.md high-signal — anti-noise / anti-overfit)
Append to `docs/INCIDENTS.md` ONLY when a REAL failure with a generalizable root cause was diagnosed —
i.e. it caused a wrong result / data loss / outage / hours lost. NOT transient stalls, typos, or trivial
fixes. **Dedupe**: update an existing entry if the same failure-class is already logged. Format:
```
### <title>   [category: deps|concurrency|error-handling|validation|data-integrity|…] [severity]
Symptom · Root-cause CLASS · Fix · Guard: what a FUTURE plan should check for
```

## Note
The reviewer is read-only and pinned to `opus`. An automatic gate (an ExitPlanMode hook) was prototyped and
**removed** — it deadlocked with plan mode's write restrictions and added risk for little gain. If revisiting,
use a plan-file stamp (not a Bash marker); see `docs/BULLETPROOF_GATE_DESIGN.md`.
