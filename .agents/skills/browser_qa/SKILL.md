---
name: browser_qa
description: >-
  EXPLICIT INVOCATION ONLY — fires ONLY when the user explicitly types "/browser_qa" or asks by name to
  "browser test", "visual QA", or "e2e audit". Do NOT auto-invoke it on standard web layout changes.
  Automated browser QA, visual regression, and E2E verification skill. Automates Playwright/DevTools browser testing, visual alignment, DOM state checks, accessibility (a11y) audits, and slow-network/error state testing.
---

# Browser QA — Visual & Interaction E2E Verification (manual)

Run when verifying web application UI/UX, interaction flows, visual regression, or DOM states: `/browser_qa` / `"browser test"` / `"visual QA"`.

---

## 🌐 QA Verification Roster

### 1. Visual & Layout Math
- Verify element alignment, spacing grid consistency, font rendering, and zero layout overflow at desktop and mobile viewports.
- Check responsive behavior at standard breakpoints (1440px, 1024px, 768px, 375px).

### 2. Interaction & State Testing
- **Happy Path**: Click through key user workflows from start to finish.
- **Edge States**: Verify empty data views, dense data views, loading spinners, error banners, and offline states.
- **Accessibility (a11y)**: Check keyboard tab focus indicators, ARIA attributes, and color contrast compliance.

---

## Output Contract
- **QA Summary**: Verified viewports, passing interaction paths.
- **Issues Identified**: Element, Line/Selector, Visual/Behavioral Defect, Recommended CSS/JS Fix.
