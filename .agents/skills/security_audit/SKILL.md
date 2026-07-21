---
name: security_audit
description: >-
  EXPLICIT INVOCATION ONLY — fires ONLY when the user explicitly types "/security_audit" or asks by name to
  "security audit" or "scan for vulnerabilities". Do NOT auto-invoke it on standard code modifications.
  Adversarial security and vulnerability audit gate. Scans codebase diffs and architecture for OWASP Top 10 risks, exposed secrets, auth bypasses, un-sanitized inputs, CSRF/XSS, insecure CORS, and unsafe deserialization before PR landing.
---

# Security Audit — Adversarial Vulnerability Gate (manual)

Run before landing PRs or shipping production features: `/security_audit` / `"security audit"` / `"scan for vulnerabilities"`.

---

## 🔒 Security Audit Roster & Checks

### 1. Secret Leakage & Credential Exposure
- Scan `git diff` for hardcoded API keys, JWT secrets, database URIs, private keys, or tokens.
- Verify `.env` and sensitive files are excluded in `.gitignore`.

### 2. OWASP Top 10 & Input Boundaries
- **SQL Injection**: Verify all DB queries use parameterized inputs or ORM prepared statements.
- **XSS (Cross-Site Scripting)**: Ensure user-controlled data rendered in UI/DOM is sanitized/escaped.
- **CSRF & Auth Bypass**: Check session tokens, JWT signatures, and route middleware authorization gates.
- **CORS & Headers**: Verify CORS policy does not wildcard `*` with credentials enabled.

### 3. File & Command Injection
- Verify shell command invocations do not concatenate unsanitized user inputs.
- Ensure file uploads sanitize paths to prevent Directory Traversal (`../`).

---

## 🚦 Audit Verdict Model
- **CRITICAL**: Hardcoded secrets, unauthenticated DB endpoints, direct SQL injection. (Blocks landing).
- **WARNING**: Insecure CORS, missing rate-limiting, missing security headers. (Requires fix before release).
- **PASS**: Zero high-severity vulnerabilities identified.

---

## Output Contract
- **Verdict**: `PASS` / `REQUIRES FIX`
- **Findings Table**: Category, File & Line, Vulnerability Description, Required Remediation.
