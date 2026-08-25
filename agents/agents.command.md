# agents

```mermaid
flowchart TD
  Actor["Actor: workflow-agent request"]
  Actor --> Resolve["Resolve profile, workflow, and logical project"]
  Resolve --> Delegate["Route through the workflow-agent initializer"]
  Delegate --> Outcome["Outcome: identity-bound administration"]
```

The diagram shows the portable Agents command receiving a workflow-agent administration request, resolving the exact
profile, workflow, and logical project, and delegating the unchanged request to that workflow's initializer. The terminal
outcome is identity-bound administration; unresolved scope must not be inferred or mutated by this command.

Execution route: `workflow-agent-initializer`.

## Purpose

```mermaid
flowchart TD
  Actor["Actor: user requests workflow-agent administration"]
  Actor --> Base["Load portable identity and routing invariants"]
  Base --> Delegate["Resolve and delegate to the selected workflow initializer"]
  Delegate --> Outcome["Outcome: workflow-owned lifecycle handling"]
```

For a concise overview and integration guidance, see [`README.md`](README.md).

This is the portable base contract and lightweight routing command for user-facing workflow-agent administration. It owns
generic agent identity, capability, communication, and packet invariants, but no workflow-specific agent definitions,
team membership, initialization payloads, profile data, project sources, or runtime mutation logic.

Match requests to initialize, reinitialize, archive, remove, delete, list, inspect, or explain workflow agents, including
phrases such as `initialize agents`, `initialize the dev workflow for profile <profile-id>`, and
`reinitialize <profile-id>-dev agents`.

## Resolution and delegation

```mermaid
flowchart TD
  Actor["Actor: human requests workflow-agent information or lifecycle administration"] --> Decision{"Decision: exactly one profile and workflow resolve explicitly or from one verified runtime binding?"}
  Decision -->|Allowed| Resolve["Allowed: load the selected profile binding and workflow entrypoint"]
  Decision -->|Prohibited| Blocked["BLOCKED: ask for the missing profile or workflow and mutate nothing"]
  Resolve --> Factory{"Decision: exactly one ready workflow factory exists in the logical project?"}
  Factory -->|Allowed| Delegate["Allowed: delegate unchanged intent to that workflow's persistent initializer contract"]
  Factory -->|Missing| Bootstrap["Allowed: create and verify the exact workflow factory, then delegate"]
  Factory -->|Duplicate or mismatched| Blocked
  Bootstrap --> Delegate
  Delegate --> Outcome["Outcome: workflow-owned information or lifecycle result"]
  Blocked --> Outcome
```

Resolve profiles only through the selected `ai-profile` bundle and workflows only through its configured
`ai_workflows_root`. The logical project convention is `<profile-id>-<workflow-id>`. An explicit profile/workflow pair wins;
otherwise exactly one verified runtime-bound logical project may supply the pair. Do not infer scope from the repository,
current working directory, company name, or stale task history.

After resolution, read `<ai_workflows_root>/<workflow-id>/<workflow-id>.workflow.md` and its declared
`agents/workflow-agent-initializer.md`. Before handing off the user's unchanged informational or lifecycle intent, ensure
that exactly one active factory with the initializer's exact title exists in the resolved logical project. When none
exists, create it as part of initialization using the initializer's complete current contract, exact model/reasoning,
logical-project binding, and readiness token; verify readiness before delegation. A duplicate, foreign, stale, mismatched,
or unready factory is `BLOCKED` and permits no managed-team mutation. Reinitializing managed agents reuses the one verified
factory; it never archives and recreates a healthy factory.

Factory bootstrap is workflow infrastructure, not managed-team membership. `archive all agents`, `delete all agents`, and
`remove all agents` continue to target only the roles declared by `agents/team.md`; archiving the factory requires the
human to name that exact factory task explicitly. A later `initialize` or `reinitialize` request recreates an explicitly
archived or otherwise missing factory before managing the team. The selected workflow's initializer, `agents/init.md`, and
`agents/team.md` remain authoritative after bootstrap.

## Common agent identity

```mermaid
flowchart TD
  Actor["Actor: initialized agent receives a request"] --> Decision{"Decision: exact own identity, caller identity, workflow, and logical project are verified?"}
  Decision -->|Allowed| Route["Allowed: evaluate the request within the verified identity scope"]
  Decision -->|Prohibited| Blocked["BLOCKED: do not infer identity from title, prose, cwd, or remembered context"]
  Route --> Outcome["Outcome: identity-bound request handling"]
  Blocked --> Outcome
```

Every initialized agent retains an immutable identity header containing its exact task ID, declared role ID, display
title, `profileId`, `workflowId`, logical project ID, runtime project binding, and initialization-source fingerprints. A
message carries an exact caller task ID and role plus an exact authorized return task ID. Before reading the work payload,
the recipient resolves the caller task's initialized identity header from trusted runtime state and compares its
`profileId`, `workflowId`, and logical project ID with its own. Packet claims, titles, natural-language assertions,
previous conversations, same-named tasks, repository paths, and matching workflow names are not identity evidence.

## Common capability boundary

```mermaid
flowchart TD
  Actor["Actor: identity-verified agent selects an action"] --> Decision{"Decision: current workflow explicitly grants this role the capability and route?"}
  Decision -->|Allowed| Route["Allowed: use only the declared capability through its registered route"]
  Decision -->|Prohibited| Blocked["BLOCKED: no capability inheritance, substitution, or tool-access inference"]
  Route --> Outcome["Outcome: capability-bounded action or evidence"]
  Blocked --> Outcome
```

An agent has only capabilities explicitly granted by its current workflow contracts and capability data. Tool visibility,
model ability, filesystem access, command existence, or another agent's authority never grants permission. Missing,
ambiguous, stale, or conflicting capability data fails closed. Workflow contracts may narrow this base but may not silently
weaken it.

## Common peer communication

```mermaid
flowchart TD
  Actor["Actor: initialized sender"]
  Actor --> Sender["Read sender's trusted identity header"]
  Sender --> Recipient["Resolve recipient task and trusted identity header"]
  Recipient --> Boundary{"Decision: same profile, workflow, and logical project?"}
  Boundary -->|Prohibited| ProfileBlock["BLOCKED_PROFILE_BOUNDARY: execute nothing"]
  Boundary -->|Allowed| Route{"Decision: peer role and route authorized?"}
  Route -->|Prohibited| RouteBlock["BLOCKED: no substitute, relay, or partial packet"]
  Route -->|Allowed| Send["Allowed: deliver one complete correlated packet"]
  Send --> Return["Verify return task has the same coordinates"]
  Return --> Outcome["Outcome: receipt returns inside the same profile workflow"]
  ProfileBlock --> Outcome
  RouteBlock --> Outcome
```

Agents communicate only with peers and directions declared by the current workflow. The sender verifies the exact active
recipient task before sending. Sender and recipient must have identical verified `profileId`, `workflowId`, and logical
project ID. Cross-profile, cross-workflow, and cross-logical-project agent communication is unconditionally prohibited;
no Manager, initializer, relay, command, remembered context, user wording, or matching repository may authorize or bridge
it. The human may independently address another initialized project, but an agent cannot carry a packet, authority, or
result across that boundary. It may not create a substitute agent, use a similarly titled task, route through an
undeclared intermediary, impersonate the human, or forward authority it does not own. A recipient rejects an unauthorized
or coordinate-mismatched caller or return route without reading task payloads, performing work, or sending a relay.

Every inter-agent packet includes a unique request/correlation ID; exact caller task ID and role; exact recipient task ID
and role; profile/workflow/logical-project identity; bounded intent and inputs; granted authority and prohibited effects;
required evidence or output; and exact return task ID. Workflow-specific contracts may add mandatory fields. Missing or
conflicting required fields are `BLOCKED`, not reconstructed from conversation history. Every return packet preserves the
same coordinates; a return target in another profile, workflow, or logical project is invalid even when its task ID exists.
The recipient compares packet coordinates with both trusted sender and recipient initialization headers; equality of
packet text alone is insufficient. A mismatch is reported as `BLOCKED_PROFILE_BOUNDARY` with zero payload execution.

### Allowed communication routes

- A human may directly address a workflow role according to that role's declared human-facing mode.
- An initialized agent may send one complete packet only to an exact initialized role and direction declared by its
  selected workflow.
- The sender, recipient, and return task must have identical verified `profileId`, `workflowId`, and logical project
  ID, and the packet must carry the required exact task IDs, roles, coordinates, authority, and return route.
- A recipient may return terminal evidence only to the exact verified `returnTaskId` in the same coordinates.

### Prohibited communication routes

- Direct human-style work requests to a role declared internal packet-only.
- Any cross-profile, cross-workflow, or cross-logical-project message, return, relay, or authority transfer.
- A substitute, same-named, hidden, temporary, child/subagent, or undeclared intermediary route.
- A packet with missing, conflicting, untrusted, or stale caller, recipient, coordinate, authority, or return evidence.

Every prohibited route is `BLOCKED`; the recipient performs no payload work and does not reconstruct the route from
conversation history, a title, a repository path, or remembered context.

## Bounded evidence follow-up

```mermaid
flowchart TD
  Actor["Actor: authorized supervising agent"] --> Decision{"Decision: one precise evidence gap and verified return route?"}
  Decision -->|Allowed| Investigate["Allowed: one bounded evidence investigation"]
  Decision -->|Prohibited| Blocked["BLOCKED: report missing context or repeated request to the human"]
  Investigate --> Evidence{"Decision: verifiable evidence is available?"}
  Evidence -->|Yes| Reply["Allowed: send one complete evidence reply"]
  Evidence -->|No| Blocked
  Reply --> Outcome["Outcome: lower-level role receives proof or human receives a blocker"]
  Blocked --> Outcome
```

The diagram starts with the authorized supervising agent validating one precise evidence gap and its verified return
route. A valid request permits one bounded investigation, which either returns verifiable proof to the lower-level role
or blocks and reports the missing context to the human. The same blocked path also ends a repeated request, so the
terminal outcome is one evidence reply or one human-visible cycle/blocker report, never an open-ended exchange.

When an authorized lower-level role asks its exact supervising agent for evidence required to evaluate the same bounded
assignment, the supervising agent MUST make one bounded attempt to resolve the request before reporting it to the human.
The request must carry the assignment or ticket ID when one exists, a stable evidence-request correlation ID, one precise
missing gate or proof, and the exact verified return route. The supervising agent may investigate only through its
already-declared capabilities and authorized routes. It must not acquire command, tracker, mutation, staffing, or other
authority merely to satisfy the request; it must not invent evidence, reopen scope, or create work solely for the reply.

For one `(assignmentOrTicketId, evidenceRequestCorrelationId)` pair, the supervising agent sends at most one complete
evidence reply to the exact lower-level role. The reply identifies the proof source, every unmet gate, and non-closure
status when applicable. If proof cannot be established, it sends one unavailable-evidence reply with the exact blocker
and next authorized owner. If the lower-level role repeats the same request after that reply, or asks again without a
new, materially different evidence gap, the supervising agent must not investigate or reply again. It reports the
possible cycle to the human with the correlation ID, request/reply facts, and unresolved gate. A distinct correlation ID
is insufficient by itself: a new attempt requires a materially different missing gate and does not reset an exhausted
request.

## Common readiness and contract inheritance

```mermaid
flowchart TD
  Actor["Actor: workflow initializer composes an agent"] --> Decision{"Decision: current base contract plus complete workflow-specific contracts are present and coherent?"}
  Decision -->|Allowed| Ready["Allowed: agent verifies composition and returns its exact readiness acknowledgement"]
  Decision -->|Prohibited| Blocked["BLOCKED: no partial initialization or conversational rule replacement"]
  Ready --> Outcome["Outcome: one initialized agent governed by base and workflow deltas"]
  Blocked --> Outcome
```

Every workflow agent extends this base contract through the selected `ai_commands_root`. The workflow supplies team roles,
capability grants, communication topology, lifecycle, models, readiness tokens, and any stricter packet schema. The
initializer composes the current base with those workflow-specific sources. A changed base or workflow contract requires
the workflow's declared reload or reinitialization path before an existing agent may rely on it.

## Boundary

```mermaid
flowchart TD
  Actor["Actor: portable Agents command"]
  Actor --> Decision{"Request belongs to portable routing or workflow mutation?"}
  Decision -->|Portable routing| Allow["Allowed: resolve, ensure one ready factory, and delegate within the contract"]
  Decision -->|Workflow mutation| Block["Prohibited here: workflow initializer owns mutation"]
  Allow --> Outcome["Outcome: boundary-preserving result"]
  Block --> Outcome
```

This command never creates or edits agent, workflow, profile, project, rule, Markdown, or configuration files. Its only
task mutation is the exact missing-factory bootstrap defined above: create one workflow-declared factory, reconcile only
that fresh task's exact title when required, and verify its readiness token before delegation. It never archives an
existing factory, creates or substitutes a managed role, mutates the managed team directly, or performs product, tracker,
governance, shell, browser, scheduler, or publication work. All managed-team mutation is performed by the resolved ready
workflow initializer under the workflow-owned lifecycle contract.
