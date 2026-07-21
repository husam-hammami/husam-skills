---
name: db_sentinel
description: >-
  EXPLICIT INVOCATION ONLY — fires ONLY when the user explicitly types "/db_sentinel" or asks by name to
  "check migration" or "database audit". Do NOT auto-invoke it on standard SQL queries or schema edits.
  Database schema and migration safety sentinel. Enforces zero-downtime migration patterns, table lock prevention, index coverage analysis, backward-compatible column renaming, and idempotent data backfills.
---

# DB Sentinel — Zero-Downtime Schema & Migration Guard (manual)

Run when reviewing database migrations, schema edits, or index additions: `/db_sentinel` / `"check migration"` / `"database audit"`.

---

## 🗄️ Migration Safety Rules

### 1. Lock Prevention (Zero Downtime)
- Never run blocking `ALTER TABLE ... ADD COLUMN` with complex defaults on large production tables without non-blocking mechanisms.
- Avoid adding un-indexed foreign keys that trigger full table locks on write operations.

### 2. Backward Compatibility
- **Renaming Columns/Tables**: Require 2-phase migration (Add new column -> Dual-write in application -> Backfill -> Deprecate old column).
- **Removing Columns**: Ensure column removal is deployed only *after* all application instances stop referencing it.

### 3. Index & Query Optimization
- Verify new query filters have supporting composite indexes.
- Ensure migration scripts are **idempotent** (safe to re-run on retry failures).

---

## Output Contract
- **Migration Risk Rating**: `LOW` / `MEDIUM` / `HIGH (BLOCKING)`
- **Safety Checklist**: Lock Check, Backward Compatibility Check, Rollback Plan Check.
