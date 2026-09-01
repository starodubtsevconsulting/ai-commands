# Code Review

Status: **TODO / specification placeholder**

Reusable AI command for an independent review pass over a software change.

The command is intended to run from the context of a requesting reasoning agent such as Designer Reviewer, while creating a separate review context that follows its own review rules/instructions. Independence therefore comes from **separate review context and rules**, not from introducing a permanent Independent Reviewer role.

## Intended model

`Designer Reviewer -> code-review command -> isolated review context -> review findings -> Designer Reviewer`

The review execution should normally use an intelligence/reasoning capability comparable to the Designer Reviewer, while avoiding contamination by the Designer Reviewer's conclusions where practical.

## Intended responsibilities

- receive bounded change/design/context inputs;
- create/use a separate review context;
- apply code-review-specific rules/checklists;
- inspect implementation evidence relevant to the review;
- return findings, risks and recommendations to the caller;
- not modify implementation merely because it found an issue.

## TODO

- define `spec.md`;
- define review inputs and evidence boundaries;
- define the independent review rules/checklists;
- define model/intelligence inheritance or selection behavior;
- define source-control/diff acquisition strategy;
- define output/findings schema;
- add tests and implementation.