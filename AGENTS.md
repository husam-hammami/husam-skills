# Global Agent Directives & Communication Style

## Concise & Direct Communication Contract (Enforced Globally)

- **Extreme Brevity**: Keep all responses, plans, and explanations direct, crisp, and to the point. Eliminate conversational fluff, filler text, and restating the prompt.
- **Lead with Results**: Lead immediately with the decision, code diff, answer, or verdict. Never output preambles like *"I will now proceed to..."*, *"Let me search for..."*, or *"I am going to check..."*.
- **No Emojis**: Avoid using emojis across all responses, headers, and artifacts unless explicitly requested.
- **Silent Tool Operations**: Perform research, file inspection, and terminal commands quietly. Do not narrate intermediate tool calls.
- **No Redundant Summaries**: Do not summarize code or artifacts in chat when the file or diff speaks for itself. Provide only high-signal bullet points when requested.
- **Structured Formatting**: Use short bullet points, tables, key-value summaries, and code blocks rather than multi-paragraph explanations.

## Project Context & Memory Protocol (CLAUDE.md / CONTEXT.md / AGENTS.md)

- **Automatic Context Discovery**: Check for project memory files (`CLAUDE.md`, `CONTEXT.md`, or `AGENTS.md`) at the project root silently before planning or modifying code.
- **Single-Read Efficiency**: Read project memory files once per session or slice only the required section using line numbers. Never re-read identical files repeatedly within the same session.
- **Context Primacy**: Adhere strictly to architectural boundaries, naming conventions, test commands, and tech stack choices defined in `CLAUDE.md` / `CONTEXT.md`.
- **Incremental Knowledge Retention**: When resolving major design decisions, new architectural patterns, or environment setups during a session, update `CLAUDE.md` / `CONTEXT.md` inline so future sessions don't re-discover facts from scratch.

---

# Skills

This workspace ships fourteen agent skills. Each is a self-contained instruction file under
`skills/<name>/SKILL.md`. **When a trigger below matches the user's request, read that
skill's `SKILL.md` in full and follow it as binding instructions before doing the work.**
Some skills have a `references/` folder — read those files when the SKILL.md points at them.

They form one pipeline: **design → plan → review → build → audit → polish.**

```
design_concept ──▶ warcry ──▶ bulletproof ──▶ katana ──▶ design_copy
 (concept)         (plan)      (verdict)      (build)     (copy)
                        eagleye ── circuit-breaker, any point

          strike (streamlined single-agent fast-track alternative)
```

| Skill | Trigger words | What it does |
|---|---|---|
| **strike** | `/strike`, "strike", "fast track" | Streamlined single-agent fast-track pipeline (Design → Plan → Review → Build → Audit → Polish) delivering full rigor and surgical accuracy at minimal token cost. |
| **design_concept** | `/design_concept`, "daedalus", new screen, redesign, mockup prompt, critique this UI | Invents original, defensible UI concepts against a numeric craft rubric. Owns structure/interaction/motion. Outputs a concept + one mockup prompt. Feeds `warcry` — never `katana` directly. |
| **design-with-product-dna** | premium UI that must match an existing product, design system coherence | Invent/critique/refine/implement UI that belongs to an existing product without copying its screens. |
| **warcry** | `/warcry`, "sound the warcry", "convene the army", plan a new feature | Fans out read-only scouts in parallel, synthesizes candidate approaches, runs a judge/adversarial panel, authors a plan, hands it to `bulletproof`. **Plan only — never implements.** |
| **bulletproof** | `/bulletproof`, "bulletproof this plan" | Adversarially pressure-tests a plan against the project's real past failures and actual code. Returns `SUFFICIENT` / `INSUFFICIENT` + must-haves. Read-only. |
| **katana** | `/katana`, "execute the plan", "build the plan" | Executes an approved `VERDICT: SUFFICIENT` plan. Slices it into disjoint work-cards, runs them in parallel on isolated git worktrees, integrates through a verify gate. Never pushes or deploys. |
| **eagleye** | `/eagleye`, "zoom out", "are we in a rabbit hole", "are we lost", "step back" | Mid-session trajectory audit. Reconstructs the original objective, has fresh agents judge drift cold, returns `ON TRACK` / `DRIFTING` / `LOST`. Read-only and advisory. |
| **design_copy** | `/sincere`, "humanise the copy", "fix the UX writing" | Rewrites UI display strings to sound human. Never touches code, keys, enums, or clinical/legal terms. |
| **grill-with-docs** | "grill me on this plan", challenge a plan against the domain model | Relentless one-question-at-a-time interview that sharpens terminology and updates `CONTEXT.md` / ADRs inline. |
| **root_cause_tracing** | `/root_cause_tracing`, "debug this failure", "trace root cause" | Surgical debugging protocol that eliminates superficial symptom patches and forces upstream tracing. |
| **security_audit** | `/security_audit`, "security audit", "scan for vulnerabilities" | Adversarial security vulnerability gate checking OWASP Top 10, secret leaks, and auth bypasses. |
| **db_sentinel** | `/db_sentinel`, "check migration", "database audit" | Zero-downtime database schema and migration safety sentinel. |
| **browser_qa** | `/browser_qa`, "browser test", "visual QA", "e2e audit" | Automated E2E browser testing, visual regression, accessibility (a11y), and DOM state verification. |
| **memory_sentinel** | `/memory_sentinel`, "maintain memory", "prune rules", "update CLAUDE.md" | Context & Memory Sentinel. Automatically updates, prunes, and optimizes project memory files to maximize alignment and minimize token consumption. |

## Invocation is manual — this is the cost gate

**Every skill here is EXPLICIT-INVOCATION ONLY.** Fire one only when the user types its slash command or
names it. Do **not** infer an invocation because a request merely resembles what a skill does — a request
to plan a feature is not `/warcry`, "build the plan" is not `/katana`, and a task involving UI is not
`/design_concept`. In every such case, just do the work inline or use `/strike`.

`warcry` and `katana` spawn parallel subagent fleets and cost real money per run. If one of them looks
genuinely warranted and the user did not ask, **say so in one line and let them decide.** Never
self-invoke `eagleye` on suspicion of drift, and never run it on a schedule.

## Rules that hold across all of them

- **Read the whole SKILL.md before acting.** These are procedures, not summaries.
- `warcry`, `bulletproof`, and `eagleye` are **read-only** — they plan, judge, and audit; they never edit.
- `katana` and `strike` write code (`katana` via multi-agent worktrees, `strike` via single-agent fast-track).
- Never skip the gate: `design_concept` → `warcry` → `bulletproof` → `katana`. Design does not hand to build.
- None of them push, deploy, or take destructive action without an explicit instruction.
