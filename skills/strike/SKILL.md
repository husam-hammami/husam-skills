---
name: strike
description: >-
  EXPLICIT INVOCATION ONLY — fires when the user types `/strike` or says "strike this" / "fast track it".
  Do NOT auto-invoke it because a request sounds like it wants rapid or surgical execution; ordinary
  requests are already single-agent and cheaper still, so just do those inline. Spawns ZERO subagents.
  Streamlined single-agent fast-track pipeline (Design → Plan → Review → Build → Audit → Polish) applying
  the swarm suite's craft standards and surgical contracts in one disciplined serial pass, at roughly the
  cost of ordinary chat. The middle setting between unstructured chat and the multi-agent fleet: it buys
  scope discipline and a real verify gate, not the adversarial rigor of `/warcry` → `/bulletproof`.
---

# Strike — Surgical, Low-Cost Single-Agent Pipeline (manual)

Run when the user types `/strike` or says "strike this" / "fast track it".

`strike` condenses the full 6-phase lifecycle (**Design → Plan → Review → Build → Audit → Polish**) into a single, highly disciplined serial pass within one agent session.

**Set expectations honestly.** Strike gives you the suite's *contracts* — declared scope, forbidden verbs,
completeness rule, deterministic gate. It does not give you the suite's *rigor*: one pass cannot replace
independent scouts or an adversarial reviewer. Never describe a strike as bulletproofed.

## Phase 0 — Fit check (seconds, before anything else)

Strike fits when the change is **bounded and understood**: the files are nameable and the approach isn't
in question. Otherwise hand off — say which in one line, and stop:

| Signal | Go here |
|---|---|
| Approach genuinely unclear, or 2+ real alternatives | `/warcry` |
| A plan exists but hasn't been pressure-tested | `/bulletproof` |
| 3+ genuinely independent units in separate areas | `/katana` |
| ∀-shaped ("do X to ALL Y") with no enumeration yet | `/warcry` — it needs a completeness inventory first |

Being handed a `VERDICT: SUFFICIENT` plan is **not** a reason to strike it — that plan earned `/katana`.
Strike is for work that never needed a plan.

---

## ⚡ The Strike Pipeline (1 Agent, 0 Swarm Overhead)

```
[1. CONCEPT & DNA] ──▶ [2. SHARP PLAN] ──▶ [3. BULLETPROOF GATE] ──▶ [4. SURGICAL BUILD] ──▶ [5. VERIFY & POLISH]
  Craft & 3-sec contract   Verbatim ask & scope     Sanity & failure classes   Forbidden verbs & diffs     Tests & human copy
```

---

## Phase 1 — Concept & Product DNA (Design)
*If the request touches UI/UX; skip for backend/pure infra.*
- **Three-Second Contract**: Define the 3 core questions: What is true now? What deserves attention? What action is obvious?
- **Preserve DNA**: Match existing typography, contrast, spacing rhythms, and color tokens. Do not introduce generic SaaS purple/indigo glow unless specified.
- **Restraint & Motion**: Use clean visual hierarchy and functional state transitions. No unneeded decorative clutter.

## Phase 2 — Sharp Plan (Plan)
- **Anchor Verbatim**: Quote the exact user ask to prevent goal drift.
- **Define Outcome**: State the exact 1–2 observable signals that mean the feature works.
- **Completeness Contract (∀-shaped tasks)**: For bulk/sweep changes (i18n, symbol rename, route sweeps), enumerate 100% of the target population with machine-checkable commands. Partial coverage is banned.
- **Load-Bearing Assumptions & Guardrails**: Identify what is in-scope vs explicitly out-of-scope.

## Phase 3 — Inline Review (Bulletproof Gate)
- **Grounding Check**: Match the plan against the project's deployment model, `git log -15`, and known failure classes (`INCIDENTS.md` if present).
- **Self-Sanity Gate**: Is this solution over-engineered? Are dependencies frozen? Is there an easier path?
- **Stamp**: Proceed only if the plan holds as `SUFFICIENT`.

## Phase 4 — Surgical Build (Katana Execution)
- **Scope Contract**: Touch ONLY the files listed in the plan.
- **Forbidden Verbs**: **DO NOT** refactor, extract abstractions, cleanup dead code, reorder imports, or optimize surrounding code outside the scope list.
- **Style Reference**: Match local house style (naming, error handling, comment style) exactly. Keep diffs tight and surgical.

## Phase 5 — Deterministic Verification & Polish (Verify + Sincere Copy)
- **Deterministic Gate**: Run unit tests, type-checks, linters, or build scripts. Never declare success without empirical terminal evidence.
- **Trajectory Audit (Eagleye Snap)**: Confirm the final diff directly matches the Phase 2 verbatim ask without scope-creep.
- **Human Copy (Sincere)**: Quietly refine UI display strings to plain, sincere human copy (no robotic filler, keep product voice). Never touch code logic, keys, or interpolation variables.

---

## 🔒 Hard Rules
1. **Single Agent Only — zero subagents, no exceptions.** Not one, not "just a quick scout". Spawning
   turns strike into katana without the worktree isolation and merge gates that make katana safe, and it
   silently costs what you invoked strike to avoid. If the task genuinely needs a fleet, stop and hand off
   per Phase 0 — that is the answer, not a small swarm.
2. **Scope gate before verify (blocking).** Run `git diff --name-only` and compare against the Phase-2
   file list. Anything outside it means the contract broke: revert the off-card edits or re-declare the
   scope out loud. Never widen scope quietly. Diffstat sanity too — "planned ~15 lines, diff is 90" gets
   inspected and explained before proceeding.
3. **Two reds means the approach is wrong, not the code.** Do not loop on fixes more than twice. Stop,
   report the failing output, and surface `/eagleye`. Thrashing inline is how a cheap strike gets expensive.
4. **Surgical Diffs**: Reject off-scope file edits. A 10-line plan modification must not become a 100-line rewrite.
5. **Empirical Gate**: Must run local verify commands (`npm test`, `pytest`, `tsc`, etc.) before reporting completion. Paste the actual result — never characterize it, never report success on a red gate.
