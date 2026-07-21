---
name: grill-with-docs
description: >-
  EXPLICIT INVOCATION ONLY — fires when the user types `/grill-with-docs` or asks to be grilled on a plan.
  Do NOT auto-invoke it whenever a plan or documentation is in play; it is a long interactive interview.
  Grilling session that challenges your plan against the existing domain model, sharpens terminology, and
  updates documentation (CONTEXT.md, ADRs) inline as decisions crystallise.
---

<what-to-do>

Interview me relentlessly about every aspect of this plan until we reach a shared understanding. Walk down each branch of the design tree, resolving dependencies between decisions one-by-one. For each question, provide your recommended answer.

Ask the questions one at a time, waiting for feedback on each question before continuing.

If a question can be answered by exploring the codebase, explore the codebase instead.

</what-to-do>

<supporting-info>

## Domain awareness

During codebase exploration, also look for existing documentation. Create files lazily — only when you have something to write.

## During the session

### Challenge against the glossary
When the user uses a term that conflicts with existing language in CONTEXT.md, call it out immediately.

### Sharpen fuzzy language
When the user uses vague or overloaded terms, propose a precise canonical term.

### Discuss concrete scenarios
Stress-test with specific scenarios that probe edge cases.

### Cross-reference with code
When the user states how something works, check whether the code agrees. Surface contradictions.

### Update CONTEXT.md inline
When a term is resolved, update CONTEXT.md right there. Don't batch. CONTEXT.md is a glossary only — no implementation details.

### Offer ADRs sparingly
Only when: hard to reverse, surprising without context, and result of a real trade-off.

</supporting-info>
