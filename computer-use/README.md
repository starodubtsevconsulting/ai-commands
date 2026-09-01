# Computer Use

Reusable AI Command for observing/interacting with an **already available graphical target** through capabilities supplied by the selected AI harness/runtime.

The command is harness-aware at runtime but harness-independent in its contract.

## Inputs

| Input | Required | Meaning |
| --- | --- | --- |
| `harness` | yes | Harness/runtime implementation to use, e.g. `codex`, `claude-code`, `hermes`, `pi`, or a future registered harness name. |
| `source` | yes | Active workflow source/project identifier whose UI/context is being observed. |
| `target` | yes | Already available UI target/session, e.g. desktop application/window, browser/tab/page, or runtime-specific target reference. |
| `goal` | yes | Bounded observation/interaction objective. |
| `interaction_scope` | no | Additional allowed interaction boundary when needed. |

Harness names are runtime identifiers, not permanent enum values in this specification. Implementations may add/retire harness adapters without changing the command's conceptual contract.

## Harness capability model

`computer-use` does not assume GUI access is implemented by a shell program or this repository. Harness may expose it through built-in capability, plugin, MCP/tool, desktop/browser control, screenshots or another mechanism.

`computer-use(harness, source, target, goal) -> harness adapter -> actual vision/desktop/browser capability`

If requested harness is unknown, unavailable, lacks compatible capability or is not authorized, return `BLOCKED`.

## Source/project context

`source` identifies the concrete workflow subject/project. Runtime resolves source-specific context needed to understand the target, but this command does not own project startup/lifecycle.

For example, source configuration may tell the caller/runtime which product/workspace is active and where related acceptance assets live. It does not imply `computer-use` should start that product.

## Target and startup boundary

`computer-use` is primarily an **observe/interact** command, not a launcher.

The target MUST normally already exist and be reachable through the selected harness:

- running desktop application/window;
- existing browser/tab/page;
- another registered graphical session/target.

If target is absent/not running, return `BLOCKED` with the missing prerequisite. Starting a project/application/server/browser belongs to a separate lifecycle/launch capability or workflow flow unless a future explicit command extension says otherwise.

This keeps responsibilities clear:

`prepare/start target -> computer-use observes/interacts with target`

not:

`computer-use guesses how to launch every possible product`

## Prompt / intent scenarios

| Example prompt / intent | Command action | Required inputs / context | Result / notes |
| --- | --- | --- | --- |
| "Look at this screen" | observe current UI | harness + source + target + goal | bounded observations |
| "Open settings and inspect this option" | interact + observe | harness + source + target + goal/scope | bounded actions/observations |
| "Learn how this UI flow works" | exploratory interaction | harness + source + target + goal | structured observations |

## Intended use

A caller such as UI Acceptance Tester may use this command to discover/relearn a UI and then encode that knowledge into stable project-owned automation such as Playwright tests/helpers. Repeatable verification should normally use encoded automation when available.

## Result policy

```text
preserve-raw-output: false
result-mode: bounded
```

Large visual traces are not automatically retained. Runtime/project may preserve authorized evidence explicitly.

## Command delegation

| Command | Access | Purpose |
| --- | --- | --- |
|  |  |  |

No nested AI Command dependency is granted by default.

## Boundaries

- Requires explicit caller/workflow/runtime authorization.
- Requires explicit `harness`, `source`, `target`, and `goal`.
- Does not launch/start arbitrary projects or applications.
- Does not bypass OS/application permissions or harness safety controls.
- Does not infer capability merely because another harness supports it.
- Returns bounded results to protect caller context.
- Product-specific selectors/test code belong to project, not this command.