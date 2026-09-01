# AI Command Specification

Common contract for reusable AI Commands.

## Command delegation — not granted by default

An AI Command may call/delegate to another AI Command only when that dependency is explicitly granted by the calling command.

Command-to-command access is **not granted by default**.

`dependency not listed -> command may not call it`

An explicit `forbidden` dependency documents an intentional no-go. Omission means simply not granted.

This prevents a command from silently expanding its authority by discovering and invoking arbitrary commands from the global AI Commands catalog.

## Required command header

Every command README/spec MUST contain a **Command delegation** section with this table, even when empty:

| Command | Access | Purpose |
| --- | --- | --- |
|  |  |  |

`Access` is normally:

- `allowed` — this command may call/delegate to the referenced command when needed;
- `forbidden` — explicit no-go;
- absent row — not granted.

Example:

| Command | Access | Purpose |
| --- | --- | --- |
| `source-control` | `allowed` | Retrieve the bounded diff/history required for review. |
| `ticket-tracker` | `forbidden` | Code review does not perform ticket administration. |

## Effective authority

A nested command call must never become a privilege-escalation path.

The effective call requires all applicable gates to allow it:

`caller/workflow authorization + calling-command delegation grant + called-command/runtime authorization -> execute`

A command cannot use its dependency list to grant the original caller authority that the caller/workflow explicitly forbids.

## Dependency versus implementation detail

The delegation table describes command-level dependencies/communication boundaries, not library/package dependencies. Internal code dependencies belong to implementation/package metadata.

## Structural consistency

Every command keeps the Command delegation section/table even when it currently delegates to nothing. This makes command composition visible and machine-readable from a predictable location.

## Minimum acceptance checklist

- [ ] Command delegation section exists.
- [ ] Delegation table exists even if empty.
- [ ] Every nested AI Command call is explicitly `allowed`.
- [ ] Important no-go dependencies may be explicitly `forbidden`.
- [ ] Missing dependency means not granted.
- [ ] Nested calls cannot bypass caller/workflow/runtime authorization.