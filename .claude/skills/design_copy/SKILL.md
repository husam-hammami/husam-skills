---
name: design_copy
description: >-
  UX Copy — Rewrite UI copy to sound sincere and human, fix weak UX writing, and remove line breaks the layout doesn't need
  — quietly, like a sharp human editor. Use when the user says "/sincere", "humanise the copy", "fix the UX
  writing", or "make this sound human". Invokes `humanise-text` to rewrite. Edits only display strings — never
  code, keys, interpolation vars, enum/status values, or clinical/legal terms, and never strengthens a hedged
  medical claim. Reports only before→after of what changed — no process narration. Project-agnostic, manual.
---

# Sincere — make UI copy human (manual)

**OUTPUT CONTRACT — obey this above all.** Search and read **silently**: emit NO text between tool calls — no
"I'll start by…", "Let me find…", "Memory is clear…", no recap of what you left untouched. Your entire reply is
the result. **If nothing needs changing, your entire reply is ONE sentence and you stop.** Anything more is a bug.

**The job:** rewrite weak / generic / AI copy into plain, specific, human lines; fix the UX writing; remove line
breaks the layout could wrap on its own (`<br>`/`\n`/split strings). Default to improving — don't hunt for reasons
to skip. `humanise-text` does the actual rewriting (fail loud if it's missing); keep the product's terse,
matter-of-fact voice (not chatty, no emoji).

**Never touch:** code · logic · i18n KEYS · interpolation vars (`{x}` / `%s` / `${…}`) · enum/status values used
in a comparison/`switch`/key · URLs · clinical/legal terms · confidence hedges ("likely / possible / cannot be
reliably assessed" — never strengthen certainty). For approved/personal copy (founder notes): keep the first-person
voice + the facts, never slogan-ify — you may still tighten wording and fix breaks, shown as before→after for
approval. Any dual-use or ambiguous string → skip.

**Verify (only if you edited anything):** it still builds, every var resolves, no premature wrap on a wide screen;
revert anything that breaks. No edits → no verify.

**Report:** one line — `N made human · K left` — then ONLY the changes as `before → after`, grouped by screen.
Nothing else. The user approves; nothing auto-commits.

Suite: **design_concept** designs the look, **sincere** makes the words human. Runs after a UI is built. The only skill
that rewrites display strings (`design-review` just flags slop).
