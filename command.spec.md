# AI Command Specification

Common contract for reusable AI Commands.

## Input contract

Every AI Command MUST define its inputs explicitly, even when it has no command-specific inputs.

Required template:

| Input | Required | Meaning |
| --- | --- | --- |
|  |  |  |

Inputs are the command's semantic contract, not necessarily CLI flags/function parameters. Runtime/harness adapters may map them to concrete invocation mechanisms.

Rules:

- required inputs are explicit;
- missing required input causes clarification/`BLOCKED`, not guessing;
- source/project/harness/target identifiers are declared when the command depends on them;
- inputs do not grant authority; authorization is evaluated separately;
- implementation-specific values should not be hard-coded into the reusable contract when a runtime mapping is appropriate.

## Output contract

Every AI Command MUST define what useful result it returns to its caller, including commands whose primary effect is observational or side-effecting.

Required template:

| Output | Meaning |
| --- | --- |
|  |  |

Output is the **caller-usable semantic result**, not necessarily raw stdout/files/tool payloads.

Examples:

- source-control commit -> commit/reference/status;
- logs -> bounded diagnostic evidence/summary;
- ticket-tracker create -> ticket identifier + resulting state;
- computer-use observe -> bounded visual/UI observation report;
- side-effect-only operation -> success/failure/status evidence.

A command SHOULD return enough structured evidence for the caller to reason about what happened without exposing unnecessary raw data.

## Prompt / intent scenarios

Every AI Command MUST contain a prompt/intent scenario table describing representative natural-language requests that map to bounded actions.

| Example prompt / intent | Command action | Required inputs / context | Result / notes |
| --- | --- | --- | --- |
|  |  |  |  |

Mappings are semantic examples, not exact-string matching. They do not grant authority. Workflow/team routing decides whether/when a role reaches the command.

## Command result policy

Every command declares how output is handled by callers such as Command Runner.

| Property | Meaning |
| --- | --- |
| `preserve-raw-output` | Whether raw/detailed output should be preserved/referenced when available. |
| `result-mode` | Caller-facing style such as `summary`, `bounded`, or `reference`. |

The **Output contract** says *what the command returns*. The **Result policy** says *how that result/raw evidence is delivered/preserved*.

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
- [ ] Outputs table defines caller-usable semantic result.
- [ ] Missing required input blocks/clarifies rather than guesses.
- [ ] Prompt/intent table exists even if empty.
- [ ] Prompt mappings do not create authority.
- [ ] Result policy exists.
- [ ] `preserve-raw-output` and `result-mode` are declared.
- [ ] Command delegation table exists even if empty.
- [ ] Every nested AI Command call is explicitly allowed.
- [ ] Nested calls cannot bypass authorization.