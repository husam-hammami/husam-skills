---
name: memory_sentinel
description: Context & Memory Sentinel. Automatically updates, prunes, and optimizes project memory files (CLAUDE.md, CONTEXT.md, AGENTS.md) to maximize domain alignment and minimize token consumption. Use when the user says "/memory_sentinel", "maintain memory", "prune rules", "update CLAUDE.md", "update CONTEXT.md", or when you need to clean up rules files to save tokens.
---

# Memory Sentinel — Project Context Maintenance & Token Optimizer (manual)

Run when reviewing or updating persistent project context files to keep them lean, up-to-date, and token-efficient: `/memory_sentinel` / `"maintain memory"` / `"prune rules"`.

---

## ⚡ The Memory Sentinel Principles
1. **Zero Bloat Policy**: Keep `CLAUDE.md` and `CONTEXT.md` strictly under 150–200 lines. Focus only on commands, constraints, and custom failure guards.
2. **Remove Self-Evident Rules**: Delete standard programming conventions (e.g., "use descriptive variables", "write clean code") that modern LLMs already natively understand.
3. **Modular Progressive Disclosure**: Keep root-level memory files focused on global facts. Move specific subdirectory rules into modular files under `.claude/rules/` or subfolder markdown files.
4. **The Two-Strike Guard**: Only add a rule if the agent has made the same error twice in the current session. Never add preemptive hypothetical constraints.

---

## 🛠️ Maintenance Execution Workflow

### Step 1 — Audit for Bloat
- Scan root memory files (`CLAUDE.md`, `CONTEXT.md`, `AGENTS.md`) for redundancy.
- Strip historical background, philosophy, human-facing setup walkthroughs, and unused tool tips.

### Step 2 — Verify and Prune Commands
- Check if project test, build, lint, and run commands have changed.
- Remove deprecated scripts and update commands to their exact, most efficient invocations.

### Step 3 — Segment Modular Rules
- Identify rules specific to a single folder or module (e.g., testing conventions, specific API endpoints).
- Move these rules to `.claude/rules/<module>.md` or nested `CLAUDE.md` directories to prevent them from inflating the root context.

### Step 4 — Session Update Sync
- If new environment setups or critical architectural boundaries were resolved in the current session, write them cleanly into `CONTEXT.md` (for domain glossary/contracts) or `CLAUDE.md` (for actionable workflows) in a concise key-value format.

---

## Output Contract
Report only:
1. **Pruning Metric**: Total lines before vs after (e.g. `240 lines -> 110 lines`).
2. **Changes Made**: Bullet points of what was updated, removed, or modularized.
3. **Token Savings Est.**: Rough % token savings per session turn.
