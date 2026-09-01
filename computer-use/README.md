# Computer Use

Reusable AI Command for observing and interacting with a graphical user interface through capabilities supplied by the active AI harness/runtime.

This command is intentionally **harness-aware at runtime but harness-independent in its contract**.

## Harness capability model

`computer-use` does not assume that GUI access is implemented by a shell program or by this repository.

The active AI **harness** may expose computer-use/vision through built-in capabilities, plugins, MCP/tools, desktop/browser control, screenshots or another provider-specific mechanism.

Examples of harness/runtime families include Codex, Claude Code, Hermes and Pi-based harnesses. Their concrete capabilities and plugin mechanisms can differ and change over time; runtime adapters map this command contract to what the selected harness actually supports.

Conceptually:

`AI Command: computer-use -> runtime/harness adapter -> available vision/desktop/browser capability`

If the active harness has no authorized compatible capability, return `BLOCKED` rather than pretending GUI access exists.

## Prompt / intent scenarios

| Example prompt / intent | Command action | Required inputs / context | Result / notes |
| --- | --- | --- | --- |
| "Look at this screen" | observe current UI | active target/session | bounded visual/UI observations |
| "Open settings and inspect this option" | interact + observe | target + allowed interaction scope | bounded observations/actions |
| "Learn how this UI flow works" | exploratory interaction | target + goal + allowed scope | structured observations usable by caller |

## Intended use

This is a bounded capability command, not a permanent substitute for deterministic automation.

A caller such as UI Acceptance Tester may use it to discover/relearn a UI and then encode that knowledge into stable automation (for example project-owned Playwright tests/helpers). Subsequent repeatable verification should normally use the encoded automation when available.

## Result policy

```text
preserve-raw-output: false
result-mode: bounded
```

Screenshots/video/large visual traces are not automatically retained by this command contract. A runtime/project may explicitly preserve evidence when required by an authorized flow.

## Command delegation

| Command | Access | Purpose |
| --- | --- | --- |
|  |  |  |

No nested AI Command dependency is granted by default.

## Boundaries

- Requires explicit caller/workflow/runtime authorization.
- Runtime/harness determines available computer-use implementation.
- Does not bypass OS/application permissions or harness safety controls.
- Does not infer that a capability exists merely because another harness supports it.
- Returns bounded observations/results to avoid unnecessarily flooding caller context.
- Product-specific selectors/test code belong to the project, not this reusable command.