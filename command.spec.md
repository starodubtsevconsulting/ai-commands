# AI Command Specification

Common contract for reusable AI Commands.

Related infrastructure:

- [AI Profiles](https://github.com/starodubtsevconsulting/ai-profiles) — profile/environment context.
- [AI Workflows](https://github.com/starodubtsevconsulting/ai-workflows) — workflow, team and source/project context.

## Common execution context

AI Commands in this ecosystem are generally **profile-, workflow-, and source/project-aware**.

Most commands therefore execute within a common context such as:

`profile -> workflow -> source/project -> command-specific inputs`

These values identify **where and under what AI configuration the command is operating**. They should normally be inherited/resolved from the active runtime/session rather than repeatedly invented by each command.

Typical common context:

| Context | Meaning |
| --- | --- |
| `profile` | Active AI profile/environment/configuration. See AI Profiles. |
| `workflow` | Active reusable workflow/team context. See AI Workflows. |
| `source` / `project` | Concrete workflow subject. In Software Development this is commonly a project; other workflows may use another source type. |

A command MAY require additional context such as repository/location, harness, target, ticket or runtime/service. Those remain command-specific inputs.

Individual command documentation SHOULD reference/inherit this common context rather than repeating long definitions, while its Inputs table remains complete enough to show what the command expects.

## Input contract

Every AI Command MUST define its inputs explicitly, even when it has no command-specific inputs.

| Input | Required | Meaning |
| --- | --- | --- |
|  |  |  |

Inputs are semantic contract, not necessarily CLI flags/function parameters. Runtime/harness adapters may map them to concrete invocation mechanisms.

Rules:

- required inputs are explicit;
- missing required input causes clarification/`BLOCKED`, not guessing;
- common profile/workflow/source context is used when applicable;
- command-specific source/project/harness/target identifiers are declared when needed;
- inputs do not grant authority;
- implementation-specific values are runtime-mapped when appropriate.

## Output contract

Every AI Command MUST define what useful result it returns to caller, including observational/side-effecting commands.

| Output | Meaning |
| --- | --- |
|  |  |

Output is caller-usable semantic result, not necessarily raw stdout/files/tool payloads. Examples: commit reference/status, bounded logs evidence, ticket ID/state, UI observation report, or side-effect status evidence.

## Prompt / intent scenarios

Every AI Command MUST contain representative natural-language intent mappings.

| Example prompt / intent | Command action | Required inputs / context | Result / notes |
| --- | --- | --- | --- |
|  |  |  |  |

Mappings are semantic examples and do not grant authority. Workflow/team routing decides whether/when a role reaches command.

## Command result policy

| Property | Meaning |
| --- | --- |
| `preserve-raw-output` | Whether raw/detailed output should be preserved/referenced when available. |
| `result-mode` | Caller-facing style such as `summary`, `bounded`, or `reference`. |

Output contract says *what* command returns; Result policy says *how* result/raw evidence is delivered/preserved.

## Command delegation — not granted by default

An AI Command may call another AI Command only when explicitly granted.

`dependency not listed -> command may not call it`

## Required command sections

Every command README/spec MUST contain these sections even when tables are empty:

### Inputs

| Input | Required | Meaning |
| --- | --- | --- |
|  |  |  |

### Outputs

| Output | Meaning |
| --- | --- |
|  |  |

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

`caller/workflow authorization + calling-command delegation grant + called-command/runtime authorization -> execute`

Input/output definitions and prompt mappings cannot broaden authority.

## Minimum acceptance checklist

- [ ] Inputs table exists and required inputs are explicit.
- [ ] Common profile/workflow/source context is represented when applicable.
- [ ] Outputs table defines caller-usable semantic result.
- [ ] Missing required input blocks/clarifies rather than guesses.
- [ ] Prompt/intent table exists even if empty.
- [ ] Prompt mappings do not create authority.
- [ ] Result policy exists.
- [ ] `preserve-raw-output` and `result-mode` are declared.
- [ ] Command delegation table exists even if empty.
- [ ] Every nested AI Command call is explicitly allowed.
- [ ] Nested calls cannot bypass authorization.