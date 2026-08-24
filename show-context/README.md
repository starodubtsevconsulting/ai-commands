# Show Context

```mermaid
flowchart TD
  Context["Relevant context"]
  Context --> Explain["Explain it clearly"]
  Explain --> Human["Human understands"]
```

**Use `show-context` to explain relevant context to a human.**

It is a generic presentation command for turning bounded evidence
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

## Prerequisites

```mermaid
flowchart TD
  Package["Command contract and report template"]
  Package --> Host["Markdown-capable host"]
  Host --> Ready["Ready: no command-specific installation"]
```

The published package needs only a host that can read Markdown. Mermaid support
is recommended for rendered diagrams but is not required to read their source.
An optional HTML renderer may add its own browser and runtime prerequisites; it
must document and check them without assuming a profile, organization,
operating system, package manager, or local directory.

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
