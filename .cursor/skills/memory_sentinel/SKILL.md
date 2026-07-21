---
name: memory_sentinel
description: >-
  EXPLICIT INVOCATION ONLY — fires ONLY when the user types "/memory_sentinel" or asks by name to
  "maintain memory", "prune rules", "update CLAUDE.md", "update CONTEXT.md", or "fix memory drift".
  Do NOT auto-invoke it when a user merely asks to edit or update a context file.
  Context & Memory Sentinel. Unifies project memory files (AGENTS.md canonical, CLAUDE.md -> @AGENTS.md import),
  enforces marker-based AUTO-MANAGED sections, and prunes fluff while preserving non-negotiable rules.
---

# Memory Sentinel — Context Optimization & Anti-Drift Guard (manual)

Run when optimizing project memory, fixing instruction drift, or pruning bloated context files: `/memory_sentinel` / `"maintain memory"` / `"fix memory drift"`.

---

## 🛑 Core Sentinel Principles

1. **Single Source of Truth (`@AGENTS.md` Import)**:
   - `AGENTS.md` at project root is the canonical memory file read by all agents.
   - `CLAUDE.md` must contain a single import line: `@AGENTS.md`.
   - Never maintain separate hand-copied duplicates in both `CLAUDE.md` and `AGENTS.md`.
   - **Merge First, Never Blindly Delete**: Unifying diverged files is a reviewable merge. Never prune non-negotiable tech stack or domain constraints just to hit an arbitrary line count.

2. **Marker-Based Safety (`AUTO-MANAGED` Blocks)**:
   - Hand-written architectural rules, stack constraints, and safety guidelines live outside auto-managed blocks.
   - Automated agent updates live ONLY inside designated marker blocks:
     `<!-- AUTO-MANAGED START -->`
     `...`
     `<!-- AUTO-MANAGED END -->`

3. **Bloat Pruning (Noise Elimination)**:
   - Remove duplicate rules, temporary work notes, and resolved bug logs (move incident logs to `docs/INCIDENTS.md`).
   - Preserve all non-negotiable domain boundaries and stack constraints.

---

## 🛠️ Execution Protocol

### Step 1 — Audit & Unification (Merge Pass)
- Check project root for `CLAUDE.md`, `AGENTS.md`, `CONTEXT.md`, and `GEMINI.md`.
- Compare `CLAUDE.md` vs `AGENTS.md`. If both exist with duplicate/diverged content, present a merged draft into `AGENTS.md` and replace `CLAUDE.md` with `@AGENTS.md`.

### Step 2 — Structure & Noise Pruning (Prune Pass)
- Organize `AGENTS.md` into 4 high-signal sections:
  1. **Core Tech Stack & Commands** (build, test, lint)
  2. **Architectural Boundaries & Non-Negotiables** (what not to break)
  3. **Critical Conventions**
  4. **Auto-Managed Learned Rules** (`<!-- AUTO-MANAGED -->`)

### Step 3 — Verification
- Confirm `CLAUDE.md` imports `@AGENTS.md`.
- Verify hand-written non-negotiables are fully intact.

---

## Output Contract
- **Memory Status**: Single-source status, total bytes, token estimate.
- **Drift Resolved**: List of diverged files unified.
- **Bytes Saved**: Total tokens freed from turn-zero context budget.
