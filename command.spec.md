# AI Command Specification

Common contract for reusable AI Commands.

## Prompt / intent scenarios

Every AI Command MUST contain a prompt/intent scenario table describing representative natural-language requests that map to the command's bounded actions.

This is the command-level MCP-like discovery/routing surface. It allows callers such as Command Runner to understand that different Human/agent wording refers to the same command/action without requiring the caller to know implementation syntax.

Required template:

| Example prompt / intent | Command action | Required inputs / context | Result / notes |
| --- | --- | --- | --- |
|  |  |  |  |

The section MUST remain present even when no scenarios have been defined yet.

Rules:

- mappings are semantic examples, not exact-string matching;
- scenarios describe only actions actually owned by this command;
- a scenario MUST NOT grant authority to invoke the command;
- missing required context causes clarification/`BLOCKED`, not guessing;
- workflow/team routing decides whether/when a role reaches this command;
- Command Runner may use these mappings to resolve natural-language intent to the command/action;
- command-specific inputs, validation and execution remain defined by the command itself.

Example for `logs`:

| Example prompt / intent | Command action | Required inputs / context | Result / notes |
| --- | --- | --- | --- |
| "Show me why this service failed" | retrieve diagnostics | service/runtime + useful time/context | bounded diagnostic result |
| "Get the logs around this error" | retrieve filtered logs | error/time/service context | bounded log evidence |

## Command result policy

Every AI Command MUST declare how its result/output should be handled by callers such as Command Runner.

| Property | Meaning |
| --- | --- |
| `preserve-raw-output` | Whether raw/detailed output should be preserved/referenced when available. |
| `result-mode` | Caller-facing result style such as `summary`, `bounded`, or `reference`. |

Command Runner follows the selected command's result policy. Runtime may impose stricter size/privacy/storage limits.

## Command delegation — not granted by default

An AI Command may call/delegate to another AI Command only when explicitly granted by the calling command.

`dependency not listed -> command may not call it`

Explicit `forbidden` documents intentional no-go; omission means not granted.

## Required command sections

Every command README/spec MUST contain all of the following, even when a table is empty:

### Prompt / intent scenarios

| Example prompt / intent | Command action | Required inputs / context | Result / notes |
| --- | --- | --- | --- |
|  |  |  |  |

### Result policy

```text
preserve-raw-output: <true|false>
result-mode: <mode>
```

### Command delegation

| Command | Access | Purpose |
| --- | --- | --- |
|  |  |  |

## Effective authority

Nested command calls require all applicable gates:

`caller/workflow authorization + calling-command delegation grant + called-command/runtime authorization -> execute`

A prompt mapping or command dependency cannot broaden caller authority.

## Minimum acceptance checklist

- [ ] Prompt/intent scenario section/table exists even if empty.
- [ ] Representative natural-language intents are mapped when known.
- [ ] Prompt mappings do not create authority.
- [ ] Missing required context blocks/clarifies rather than guesses.
- [ ] Result policy exists.
- [ ] `preserve-raw-output` is explicitly true/false.
- [ ] `result-mode` is declared.
- [ ] Command delegation section/table exists even if empty.
- [ ] Every nested AI Command call is explicitly allowed.
- [ ] Missing dependency means not granted.
- [ ] Nested calls cannot bypass caller/workflow/runtime authorization.