# Response Governance

ACRO response governance is built around a safe lifecycle: suggest, simulate, policy-check, approve, execute, verify, rollback, and audit.

The lifecycle is designed to show how AI-assisted response can be useful without letting AI bypass deterministic safety controls.

## Lifecycle

| Stage | Purpose |
|---|---|
| Suggest | An agent or analyst proposes a scoped response action with rationale and evidence. |
| Simulate | The platform estimates likely impact, affected entities, and operational risk before mutation. |
| Policy-check | OPA / Rego-style policy evaluates tenant scope, action type, risk score, approval state, evidence, and rollback plan. |
| Approve | High-risk or high-impact actions route to a human approval queue. |
| Execute | Approved actions run through scoped playbooks and actuators. |
| Verify | Automated checks confirm whether the action produced the intended result. |
| Rollback | If verification fails or the action causes unexpected impact, rollback steps restore the prior state where possible. |
| Audit | The full proposal, decision, approval, execution, verification, and rollback state is written to an immutable audit receipt. |

## Proposal Requirements

A response proposal should include:

- `tenant_id`
- action type and target scope,
- evidence references,
- risk score,
- expected blast radius,
- rollback plan,
- policy context,
- requesting actor or agent,
- approval status when applicable.

## Approval Routing

Low-risk actions may be allowed automatically when policy permits. Examples include short-lived alert suppression for a known maintenance window or adding context to a case.

High-risk actions require manual approval. Examples include isolating an endpoint, revoking privileged sessions, disabling an identity, changing a cloud policy, or modifying network controls.

The default posture is conservative. New tenants or immature policies should start with human approval for response actions until evidence quality, rollback reliability, and operator trust are established.

## Kill-Switch Concept

A tenant or platform-level kill switch should be able to halt automated execution while preserving investigation and reporting. A kill switch should not erase audit history or hide pending proposals. It should force response actions into deny or approval-required states until the safety condition is cleared.

## Audit Expectations

Every response action should be reviewable after the fact. A reviewer should be able to answer:

- What finding triggered the response?
- What evidence supported the proposal?
- Which policy version evaluated it?
- Was approval required?
- Who approved or rejected it?
- What action executed?
- Did verification pass?
- Was rollback needed?
