# Agents command

The `agents` command is a portable base contract for administering and
coordinating workflow-owned AI agents. It defines the invariants that workflows
can extend without embedding a particular company, profile, project, runtime,
or team structure.

## What it provides

- Explicit `profileId`, `workflowId`, and logical-project coordinates.
- Immutable, fingerprint-backed initialized agent identity.
- Same-profile peer communication with fail-closed boundary checks.
- Capability and route authorization independent of model or tool access.
- Portable initialization, reinitialization, archival, and inspection routing.
- Vertical Mermaid diagrams suitable for narrow documentation views.

## Profile isolation

Before processing an inter-agent payload, the recipient compares its trusted
initialized identity with the sender and return-task identities. All three must
belong to the same profile, workflow, and logical project. A mismatch returns
`BLOCKED_PROFILE_BOUNDARY` and performs no work.

For example, a Designer/Reviewer initialized for `<profile-a>-dev` cannot send
work to a Coder initialized for `<profile-b>-dev`, even though both use the
independent `dev` workflow.

## Integration

A workflow extends [`agents.command.md`](agents.command.md) with its own:

- role and team definitions;
- capability and communication topology;
- initialization payload and readiness tokens;
- lifecycle and runtime adapter;
- profile and project configuration bindings.

Those workflow-specific artifacts intentionally do not belong in this command.
Profiles contain policy references and non-secret identity expectations;
credentials stay in local, ignored, provider-appropriate storage.

## Scope boundary

This command describes portable routing and safety contracts. It does not ship
a workflow, create runtime tasks itself, contain credentials, or define a
specific organization’s agents.
