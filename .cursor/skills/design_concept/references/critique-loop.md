# Critique And Refinement Loop

## Diagnose The Failure Level

### Concept Failure

Symptoms:

- the core metaphor is wrong for the task;
- the dominant artifact is decorative;
- the screen cannot support normal usage;
- the design is derivative even when well rendered.

Action: stop. Return to concept invention.

### Composition Failure

Symptoms:

- the concept is sound but hierarchy is unclear;
- primary action is difficult to find;
- content is crowded or poorly balanced;
- the reading path is wrong.

Action: preserve the concept and rewrite spatial priorities.

### Rendering Failure

Symptoms:

- malformed text or icons;
- inconsistent geometry;
- poor material realism;
- weak spacing or contrast;
- image-model artifacts.

Action: preserve concept and composition. Request a clean rerender with precise corrections.

### Reference-Copy Failure

Symptoms:

- matching silhouette or focal object;
- copied information placement;
- the reference's metaphor survives with new styling.

Action: identify the copied structural elements and return to invention or major recomposition.

### Product-Fidelity Failure

Symptoms:

- invented data or features;
- missing core workflows;
- wrong navigation;
- attractive output that cannot represent real states.

Action: correct the product contract while preserving viable visual ideas.

## Critique Format

Lead with a verdict:

> Keep, refine, or reject.

Then provide:

- `Works`: no more than three concrete strengths.
- `Fails`: the highest-impact problems in priority order.
- `Preserve`: exact elements protected from revision.
- `Remove`: exact elements that should disappear.
- `Change`: behavioral or compositional corrections.

Do not praise visual polish while ignoring product failure.

## Refinement Prompt Rules

- Reference only the chosen mockup.
- State "refine, do not redesign" when the concept is sound.
- Lock successful composition, artifact, and hierarchy explicitly.
- Limit corrections to three to six high-impact changes.
- Forbid known regressions.
- Request one screen only.

Template:

```text
Refine the attached mockup. Preserve [successful elements].

Correct:
- [change]
- [change]
- [change]

Remove [failures].

Do not redesign the concept, introduce [known regression], or imitate [reference].

Produce one polished [dimensions] mockup only.
```

## Iteration Discipline

After two failed refinements, reassess the concept. Repeatedly patching a structurally wrong idea produces polished failure.
