# Show Context

```mermaid
flowchart TD
  Evidence["Markdown, code, diff, or other evidence"]
  Evidence --> Report["Visual-first context report"]
  Report --> Human["Human understands what matters"]
```

`show-context` is a generic presentation command for turning bounded evidence
into a human-readable report. It is useful on its own and as the presentation
layer of code review, investigation, handoff, architecture, and testing flows.

## Published package

```mermaid
flowchart TD
  Contract["show-context.command.md"]
  Contract --> Template["show-context.report.template.md"]
  Template --> Outcome["Portable contract-only command"]
```

- [`show-context.command.md`](show-context.command.md) defines intent, mapping,
  report structure, safety boundaries, and completion.
- [`show-context.report.template.md`](show-context.report.template.md) is a
  visual-first starting point for reports.

This public extraction is intentionally contract-only. A host may render the
Markdown with its own browser, IDE, or report surface. Executable and local
discovery adapters can be added without changing the command contract.

## Quick start

```mermaid
flowchart TD
  Copy["Copy the report template"]
  Copy --> Replace["Replace the diagram and explanation"]
  Replace --> Trim["Remove unused evidence or decision sections"]
  Trim --> Share["Share the bounded context with a human"]
```

Start with the template, answer one question, lead with the smallest useful
visual, and include only evidence that supports understanding.
