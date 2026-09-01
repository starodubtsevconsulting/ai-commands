# Code Review

Status: **TODO / specification placeholder**

Reusable AI command for an independent review pass over a software change.

The command is intended to run from the context of a requesting reasoning agent such as Designer Reviewer, while creating a separate review context that follows its own review rules/instructions. Independence comes from **separate review context and rules**, not from introducing a permanent Independent Reviewer role.

## Intended model

`Designer Reviewer -> code-review -> source-control (when needed) -> isolated review context -> findings -> Designer Reviewer`

The review execution should normally use intelligence/reasoning comparable to the Designer Reviewer while avoiding contamination by the Designer Reviewer's conclusions where practical.

## Command delegation

| Command | Access | Purpose |
| --- | --- | --- |
| [`source-control`](../source-control/) | `allowed` | Retrieve bounded diffs, history and other source-control evidence required by the review. |
| [`ticket-tracker`](../ticket-tracker/) | `forbidden` | Code review does not perform ticket administration. |

Commands not listed are not granted. See [`command.spec.md`](../command.spec.md).

## Intended responsibilities

- receive bounded change/design/context inputs;
- create/use a separate review context;
- apply code-review-specific rules/checklists;
- obtain source-control evidence through the explicitly allowed `source-control` dependency when needed;
- inspect implementation evidence relevant to the review;
- return findings, risks and recommendations to the caller;
- not modify implementation merely because it found an issue.

## TODO

- define `spec.md`;
- define review inputs and evidence boundaries;
- define independent review rules/checklists;
- define model/intelligence inheritance or selection behavior;
- define source-control/diff acquisition behavior;
- define output/findings schema;
- add tests and implementation.