---
name: root_cause_tracing
description: >-
  EXPLICIT INVOCATION ONLY — fires ONLY when the user explicitly types "/root_cause_tracing" or says
  "debug this failure" / "trace root cause" by name. Do NOT auto-invoke it when a user merely asks to fix a bug or run a test.
  Surgical debugging and root-cause tracing protocol. Prevents superficial symptom-masking (swallowing exceptions, returning dummy fallbacks, deleting failing assertions). Forces empirical un-truncated log extraction, upstream state tracing, minimal reproduction tests, and verified root-cause resolution.
---

# Root Cause Tracing — Surgical Debugging Protocol (manual)

Run when diagnosing runtime failures, unhandled exceptions, test breakages, or silent state corruption: `/root_cause_tracing` / `"debug this failure"` / `"trace root cause"`.

---

## 🛑 The Non-Negotiable Core Principles
1. **No Superficial Symptom Patches**: Never resolve an error by wrapping in try/except, returning 0/null/empty fallback arrays, commenting out broken assertions, or deleting failing unit tests.
2. **Empirical Evidence First**: Never form hypotheses without reading the complete, un-truncated stack trace or error log.
3. **Trace Upstream to Origin**: Trace data/state mutation upstream through callers until the exact point of invalid contract entry is found.

---

## 🛠️ Tracing Execution Protocol

### Step 1 — Empirical Log & State Extraction
- Fetch the exact, un-truncated error log, stack trace, or failing test output.
- Record: exact exception type, message, failing line number, and active stack frames.

### Step 2 — Reproduction Target
- Write or isolate the smallest possible reproduction script or unit test that reproduces the failure deterministically.
- Confirm the reproduction test fails with the exact same stack trace.

### Step 3 — Upstream Contract Tracing
- Inspect caller stack frames upstream from the error location.
- Verify object initialization, null states, parameter types, and schema boundaries.
- Identify the exact line where invalid data or state mutation originated.

### Step 4 — Surgical Root-Cause Fix
- Modify the underlying logic at the root cause level (not at the symptom output site).
- Maintain existing API contracts and avoid unintended side effects across caller sites.

### Step 5 — Empirical Verification
- Run the reproduction test and confirm clean passing execution.
- Run the full test suite to guarantee zero regressions.

---

## Output Contract
Report only:
1. **Root Cause**: 1–2 sentence technical explanation of why the contract broke.
2. **Symptom vs Root Fix**: File and line numbers of the actual fix.
3. **Reproduction Evidence**: Passing test command output.
