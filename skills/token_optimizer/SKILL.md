---
name: token_optimizer
description: >-
  EXPLICIT INVOCATION ONLY — fires ONLY when the user explicitly types "/token_optimizer" or asks by name to
  "optimize tokens", "cost optimization", or "cache optimization". Do NOT auto-invoke it on standard coding tasks.
  Universal Token & Prompt Cache Optimizer. Implements Dynamic Context Relocation (Static Prefix + Tail Relocation),
  Model Tier Routing Ladder (Flash/Sonnet/Opus), Tool Schema Alphabetization, and Thread Cache Preservation to cut token costs by 60-80% without performance loss.
---

# Token Optimizer — Prompt Caching & Model Tier Ladder (manual)

Run when optimizing token consumption, prompt cache hit rates, or multi-agent routing: `/token_optimizer` / `"optimize tokens"` / `"cost optimization"`.

---

## 🛑 The Core Optimization Protocols

### 1. Dynamic Context Relocation (The Prefix Rule)
- **Static Prefix Guarantee**: Keep system instructions, rules files (`AGENTS.md`, `CLAUDE.md`, `GEMINI.md`), and tool definitions 100% byte-identical across runs. Never interpolate dynamic variables (timestamps, user IDs, active working state) directly into system prompt templates.
- **Tail Relocation**: Move all real-time variables, session notes, and working memory to a `<system-reminder>` XML block appended as a user message at the **very tail** of the request array.
- **Deterministic Tool Schema**: Alphabetize tool definitions so schema ordering never invalidates prefix caches.

### 2. Multi-Model Routing Ladder (Tiered Stack)
- **Tier 1 (Light: Flash / Haiku / Luna)**: Task classification, search/retrieval indexing, preliminary code syntax checks.
- **Tier 2 (Core: Sonnet / Terra)**: Bulk code generation, file editing, primary implementation passes (`katana` body builders).
- **Tier 3 (Architect: Opus / Sol / Pro)**: Complex logic planning, adversarial reviews (`bulletproof`), root-cause diagnosis.

### 3. Thread Cache Isolation (No Model Thrashing)
- Avoid switching models back and forth on the exact same conversation thread. Model switching invalidates and rebuilds prompt caches on both sides, doubling token costs.
- Subagents running different model tiers must execute in isolated context threads.

### 4. Single-Read Context Discipline
- Read memory files (`AGENTS.md`, `CLAUDE.md`, `CONTEXT.md`) once per session or slice required line ranges.
- Keep turn-zero context size light (< 3,000 tokens / 100 lines max for instructions) to maximize context window headroom.

---

## 🛠️ Optimization Checklist
- [ ] System prompt contains 0 inline dynamic variables.
- [ ] Real-time variables passed via `<system-reminder>` tail block.
- [ ] Tool schemas alphabetized.
- [ ] Subagents routed to appropriate model tier (Flash for retrieval, Sonnet for code, Opus for review).
- [ ] Single canonical `@AGENTS.md` import verified for cross-tool alignment.

---

## Output Contract
- **Cache Hit Projection**: Estimated prompt cache hit rate (> 80% target).
- **Model Ladder Assignments**: Breakdown of task routing by tier.
- **Estimated Savings**: Token cost reduction % vs raw un-cached multi-turn execution.
