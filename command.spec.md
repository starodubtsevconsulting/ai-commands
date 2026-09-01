# AI Command Specification

Common contract for reusable AI Commands.

## Command result policy

Every AI Command MUST declare how its result/output should be handled by callers such as Command Runner.

At minimum the command specification/README MUST declare:

| Property | Meaning |
| --- | --- |
| `preserve-raw-output` | `true` or `false`: whether the command expects raw/detailed output to be preserved or referenced when available. |
| `result-mode` | Expected caller-facing result style, for example `summary`, `bounded`, `reference`, or another command-defined mode. |

These are command semantics because the command itself best understands whether its raw output has future diagnostic value.

Examples:

- `logs`: `preserve-raw-output: true`; return a bounded summary while preserving/referencing the underlying diagnostic slice when useful.
- `source-control` commit/push: normally `preserve-raw-output: false`; Git already provides durable authoritative state/history.

Command Runner MUST read/follow the selected command's result policy rather than independently deciding whether raw output should be persisted.

Runtime may still impose stricter size/privacy/storage limits.

## Command delegation — not granted by default

An AI Command may call/delegate to another AI Command only when that dependency is explicitly granted by the calling command.

`dependency not listed -> command may not call it`

Explicit `forbidden` documents intentional no-go; omission means not granted.

## Required command sections

Every command README/spec MUST contain both:

### Result policy

```text
preserve-raw-output: <true|false>
result-mode: <mode>
```

### Command delegation

| Command | Access | Purpose |
| --- | --- | --- |
|  |  |  |

These sections remain present even when delegation is empty.

## Effective authority

Nested command calls require all applicable gates:

`caller/workflow authorization + calling-command delegation grant + called-command/runtime authorization -> execute`

A command cannot use dependencies to grant the original caller authority explicitly forbidden by workflow/runtime policy.

## Minimum acceptance checklist

- [ ] Result policy exists.
- [ ] `preserve-raw-output` is explicitly true/false.
- [ ] `result-mode` is declared.
- [ ] Command Runner can determine result handling from command metadata/specification.
- [ ] Command delegation section/table exists even if empty.
- [ ] Every nested AI Command call is explicitly allowed.
- [ ] Missing dependency means not granted.
- [ ] Nested calls cannot bypass caller/workflow/runtime authorization.