# Show Context

```mermaid
flowchart TD
  Context["Relevant context"]
  Context --> Explain["Explain it clearly"]
  Explain --> Human["Human understands"]
```

**Use `show-context` to explain relevant context to a human.**

It turns bounded evidence into a human-readable visual report.
It is a low-level presentation command: other commands and workflows may compose
it for code review, investigation, handoff, manual testing, architecture, or any
other situation where a person needs to understand context before acting.

**Usually:** inspect relevant folders, source material, conversation history,
summaries, or reports; select what matters; then present it in the form a human
can understand most easily.

Start with what the person needs to understand. Then show the smallest useful
visual, explain what it means, and add code or other evidence only when it helps.
The command presents evidence; it does not decide approval, modify the subject,
or replace a specialized review command.

## Execution role

```mermaid
flowchart TD
  Knowledge["Available knowledge and source context"]
  Knowledge --> Agent["Knowledge-capable human-facing agent"]
  Agent --> Select["Select, summarize, and explain"]
  Select --> Render["Render a visible report"]
  Render --> Continue["Continue after shared understanding"]
```

- Route to the human-facing agent responsible for the relevant knowledge. Use
  the [`agents` command](../agents/agents.command.md) to define and validate that
  agent's identity, capabilities, context boundary, and communication rules.
- Give that agent access to the bounded folders, source material, conversation
  history, summaries, or reports needed to answer the human's question.
- Do not delegate presentation-only work to an execution-only role.
- A composing command remains responsible for its own domain decisions.

`show-context` defines how context is selected and presented; it does not make a
weakly informed agent knowledgeable. Report quality depends on the connected
agent's reasoning capability, its access to the right sources, and the quality
of the surrounding context. If knowledge is missing, the agent must identify the
gap rather than invent an explanation.

## Intent mapping

```mermaid
flowchart TD
  Prompt["User prompt"]
  Prompt --> Understand{"Is the goal human understanding?"}
  Understand -->|Yes| Context["show-context"]
  Understand -->|No, direct URL| Browser["browser/open tool"]
  Understand -->|No, mutate or decide| Specialist["specialized command"]
```

Map requests such as “show the context,” “prepare a report,” “walk me through
it,” “show the code review context,” or “show the diagram, screenshots, diff, or
evidence” when the intended outcome is visible understanding.

Use a direct browser or file-opening tool when the user only wants an item
opened. Use a specialized command when the user asks for a decision, mutation,
or domain-specific procedure; that command may call `show-context` for its
human-visible result.

## Report contract

```mermaid
flowchart TD
  Scope["1. Scope and question"]
  Scope --> Diagram["2. Diagram or strongest visual evidence"]
  Diagram --> Meaning["3. Plain-language explanation"]
  Meaning --> Evidence["4. Code, diff, table, links, or screenshots"]
  Evidence --> Action["5. Decision or next action, when requested"]
```

Every generated report should:

- answer one bounded human question;
- lead with the smallest useful visual, normally a vertical Mermaid diagram;
- explain what the visual means before exposing implementation detail;
- include only evidence that changes understanding or supports a claim;
- preserve source paths or links so evidence can be inspected;
- clearly distinguish facts, inferences, risks, and recommended actions;
- omit code when code is irrelevant, and use focused snippets instead of dumps;
- avoid secrets, credentials, private configuration, and unrelated context.

Use [`show-context.report.template.md`](show-context.report.template.md) as the
portable starting point. Delete unused sections rather than filling space.

## Presentation modes

```mermaid
flowchart TD
  Evidence["Bounded evidence"]
  Evidence --> Markdown["Markdown report"]
  Evidence --> Code["Code or diff"]
  Evidence --> Media["Screenshot or shared file"]
  Evidence --> Link["URL or local path"]
  Markdown --> Page["Browser-readable context page"]
  Code --> Page
  Media --> Page
  Link --> Page
```

A host-provided renderer may render Markdown, text, and source files; select one
Markdown section; render Mermaid; highlight code and diffs; preview shared
images; and open explicitly supplied URLs or local paths. Project discovery and
local drop folders are optional integrations, not part of the portable report
contract.

## Prerequisites

```mermaid
flowchart TD
  Package["Contract, template, and Python renderer"]
  Package --> Python["Python 3"]
  Python --> Viewer["Browser or HTML viewer"]
  Viewer --> Ready["Ready to render"]
```

The portable executable requires Python 3 and a browser or HTML viewer. It uses
only the Python standard library. No command-specific installer is required.
Pygments is optional; without it, code remains escaped and readable. Mermaid is
loaded from a public CDN when network access is available, while the generated
page retains readable diagram source when it is unavailable.

## Usage

```mermaid
flowchart TD
  Source["Choose a report or evidence file"]
  Source --> Render["Render it with Python"]
  Render --> Optional["Optionally set title, question, or output"]
  Optional --> Output["Open the page or use --no-open"]
```

```bash
python3 show-context.py \
  --file <report-or-source-file> \
  --title "Context title" \
  --request "Question being answered"
```

Use `--output <path>` to choose the HTML location and `--no-open` to generate it
without opening the browser. A Markdown-capable host can also present the report
template directly without running the renderer.

## Output and completion

```mermaid
flowchart TD
  Render["Render succeeds"]
  Render --> Artifact["Visible HTML artifact"]
  Artifact --> Evidence["Print recoverable artifact/source paths"]
  Evidence --> Human["Human can inspect the same context"]
```

Completion requires a readable artifact, recoverable location, faithful source
links, and no silent mutation of the material being presented. If the available
evidence cannot answer the question, say what is missing instead of producing a
confident but ungrounded report.

The Python renderer embeds the HTML structure and CSS directly in the generated
page. By default `<source>` becomes `<source>.html` beside the input; `--output`
selects another location. It prints the artifact path and opens the system
browser unless `--no-open` is used. Mermaid renders in the browser from its
documented public CDN, with diagram source retained as the fallback. Generated
HTML is runtime output and must remain outside version control.

## Tags

```mermaid
flowchart TD
  Command["show-context"]
  Command --> Discovery["Human-facing discovery tags"]
```

`#command` `#ai-command` `#show-context` `#human-context` `#visual-report`
`#code-review` `#evidence`
