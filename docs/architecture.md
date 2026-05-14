# Architecture Case Study

ACRO is organized as a governed cyber response platform. The core design goal is to accelerate investigation and response while keeping authorization, tenancy, approval, and auditability outside the probabilistic reasoning layer.

This public case study describes the architecture at a safe level. It does not expose private source code, deployment details, secrets, or real incident data.

## Architectural Planes

| Plane | Responsibility | Representative Components |
|---|---|---|
| Data Plane | Collect, normalize, enrich, route, store, and replay security telemetry | OpenTelemetry-style collectors, OCSF-style contracts, Kafka / Redpanda, hot analytics, object evidence |
| Control Plane | Manage tenants, users, policies, approvals, incidents, cases, and workflow state | PostgreSQL-style control data, RBAC, tenant context, approval queues |
| Reasoning Plane | Retrieve evidence, explain findings, correlate context, and draft response proposals | AI-assisted agents, mediated tools, evidence summaries, proposal objects |
| Governance Plane | Decide what is allowed, denied, or escalated before response execution | OPA / Rego-style policy, autonomy levels, approval gates, kill-switch concepts |
| Audit Plane | Preserve replayable evidence of each recommendation, decision, approval, action, and outcome | Decision logs, audit receipts, evidence references, policy versions, execution status |

## System Flow

Telemetry enters the data plane from endpoint, identity, cloud, network, and SaaS sources. Events are normalized into a shared schema before they are placed on the event bus. This lets detection rules, dashboards, graph projection, and AI-assisted triage reason over the same event vocabulary.

Detections create findings from normalized events. Correlation links related activity across identities, hosts, cloud resources, and time windows. The incident workspace presents the resulting narrative as a timeline with evidence, entity pivots, and severity context.

The reasoning plane retrieves tenant-scoped evidence and produces summaries, confidence, candidate explanations, affected entities, and response recommendations. The output is a structured agent proposal, not an imperative command.

The governance plane evaluates each proposal before execution. Policy can allow low-risk actions, deny unsafe actions, or escalate actions to a human approval queue. High-risk response actions require rollback notes, evidence references, tenant context, and approval.

The response execution layer runs approved playbooks through scoped actuators. Verification checks confirm the action achieved the intended effect. If verification fails or the action exceeds its allowed scope, rollback planning is used to restore the previous state.

The audit plane records the full chain: finding, evidence, agent proposal, policy decision, approval status, execution result, verification, rollback status, and final audit receipt.

## Design Rules

1. **Agents propose, policies govern.** AI-assisted agents can explain and recommend, but they do not directly mutate protected systems.
2. **Tenant context is mandatory.** Every event, finding, proposal, policy input, and audit receipt carries tenant scope.
3. **Normalized telemetry comes first.** Detection, correlation, graph analysis, and investigation workflows depend on consistent event contracts.
4. **Graph analysis is selective.** The graph stores relationships that help explain risk and blast radius. It is not a dumping ground for every raw event.
5. **Response requires reversibility.** High-risk actions must include verification steps and rollback planning.
6. **Auditability is a product feature.** Reviewers should be able to reconstruct what happened, why it happened, who approved it, and what evidence supported the decision.

## Why This Architecture Is Recruiter-Relevant

This design demonstrates more than UI polish. It shows security engineering judgment across detection logic, event pipelines, agent boundaries, policy-as-code, incident response, graph reasoning, and audit-ready workflows.
