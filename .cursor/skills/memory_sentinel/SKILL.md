---
name: memory_sentinel
description: Context & Memory Sentinel. Automatically unifies, prunes, and optimizes project memory files (AGENTS.md, CLAUDE.md, CONTEXT.md) to eliminate instruction drift, enforce @AGENTS.md canonical linking, and minimize token bloat. Use when the user says "/memory_sentinel", "maintain memory", "prune rules", "update CLAUDE.md", "update CONTEXT.md", or "fix memory drift".
---

# Memory Sentinel — Context Optimization & Anti-Drift Guard (manual)

Run when optimizing project memory, fixing instruction drift, or pruning bloated context files: `/memory_sentinel` / `"maintain memory"` / `"fix memory drift"`.

---

## 🛑 Core Sentinel Principles

1. **Single Source of Truth (`@AGENTS.md` Import)**:
   - `AGENTS.md` at project root is the canonical memory file read by all agents.
   - `CLAUDE.md` must contain a single import line: `@AGENTS.md`.
   - Never maintain separate hand-copied duplicates in both `CLAUDE.md` and `AGENTS.md`.

2. **Marker-Based Safety (`AUTO-MANAGED` Blocks)**:
   - Hand-written architectural rules, stack constraints, and safety guidelines live outside auto-managed blocks.
   - Automated agent updates live ONLY inside designated marker blocks:
     `<!-- AUTO-MANAGED START -->`
     `...`
     `<!-- AUTO-MANAGED END -->`

3. **Bloat Budget (< 100 lines / ~2-3KB max)**:
   - Target total starting context size < 3,000 tokens.
   - Move incident logs to `docs/INCIDENTS.md` and detailed domain docs to `docs/`.

---

## 🛠️ Execution Protocol

### Step 1 — Audit & Drift Detection
- Check project root for `CLAUDE.md`, `AGENTS.md`, `CONTEXT.md`, and `GEMINI.md`.
- Compare `CLAUDE.md` vs `AGENTS.md`. If both exist with duplicate/diverged content, merge the content into `AGENTS.md` and replace `CLAUDE.md` with `@AGENTS.md`.

### Step 2 — Structure & Bloat Trimming
- Organize `AGENTS.md` into 4 high-signal sections:
  1. **Core Tech Stack & Commands** (build, test, lint)
  2. **Architectural Boundaries** (what not to break)
  3. **Critical Conventions**
  4. **Auto-Managed Learned Rules** (`<!-- AUTO-MANAGED -->`)

### Step 3 — Verification
- Confirm `CLAUDE.md` imports `@AGENTS.md`.
- Verify total line count is under 100 lines.

---

## Output Contract
- **Memory Status**: Single-source status, total bytes, token estimate.
- **Drift Resolved**: List of diverged files unified.
- **Bytes Saved**: Total tokens freed from turn-zero context budget.
