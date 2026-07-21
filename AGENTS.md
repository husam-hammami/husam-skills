# Skills

This workspace ships eight agent skills. Each is a self-contained instruction file under
`skills/<name>/SKILL.md`. **When a trigger below matches the user's request, read that
skill's `SKILL.md` in full and follow it as binding instructions before doing the work.**
Some skills have a `references/` folder — read those files when the SKILL.md points at them.

They form one pipeline: **design → plan → review → build → audit → polish.**

```
design_concept ──▶ warcry ──▶ bulletproof ──▶ katana ──▶ design_copy
 (concept)         (plan)      (verdict)      (build)     (copy)
                        eagleye ── circuit-breaker, any point
```

| Skill | Trigger words | What it does |
|---|---|---|
| **design_concept** | `/design_concept`, "daedalus", new screen, redesign, mockup prompt, critique this UI | Invents original, defensible UI concepts against a numeric craft rubric. Owns structure/interaction/motion. Outputs a concept + one mockup prompt. Feeds `warcry` — never `katana` directly. |
| **design-with-product-dna** | premium UI that must match an existing product, design system coherence | Invent/critique/refine/implement UI that belongs to an existing product without copying its screens. |
| **warcry** | `/warcry`, "sound the warcry", "convene the army", plan a new feature | Fans out read-only scouts in parallel, synthesizes candidate approaches, runs a judge/adversarial panel, authors a plan, hands it to `bulletproof`. **Plan only — never implements.** |
| **bulletproof** | `/bulletproof`, "bulletproof this plan" | Adversarially pressure-tests a plan against the project's real past failures and actual code. Returns `SUFFICIENT` / `INSUFFICIENT` + must-haves. Read-only. |
| **katana** | `/katana`, "execute the plan", "build the plan" | Executes an approved `VERDICT: SUFFICIENT` plan. Slices it into disjoint work-cards, runs them in parallel on isolated git worktrees, integrates through a verify gate. Never pushes or deploys. |
| **eagleye** | `/eagleye`, "zoom out", "are we in a rabbit hole", "are we lost", "step back" | Mid-session trajectory audit. Reconstructs the original objective, has fresh agents judge drift cold, returns `ON TRACK` / `DRIFTING` / `LOST`. Read-only and advisory. |
| **design_copy** | `/sincere`, "humanise the copy", "fix the UX writing" | Rewrites UI display strings to sound human. Never touches code, keys, enums, or clinical/legal terms. |
| **grill-with-docs** | "grill me on this plan", challenge a plan against the domain model | Relentless one-question-at-a-time interview that sharpens terminology and updates `CONTEXT.md` / ADRs inline. |

## Rules that hold across all of them

- **Read the whole SKILL.md before acting.** These are procedures, not summaries.
- `warcry`, `bulletproof`, and `eagleye` are **read-only** — they plan, judge, and audit; they never edit.
- `katana` is the only one that writes code, and only from a plan already stamped `SUFFICIENT`.
- Never skip the gate: `design_concept` → `warcry` → `bulletproof` → `katana`. Design does not hand to build.
- None of them push, deploy, or take destructive action without an explicit instruction.
