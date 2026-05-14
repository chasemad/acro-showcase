# Agent Workflow

ACRO treats AI as an investigation and response assistant, not an unrestricted operator. Agents help analysts move faster by summarizing evidence, explaining detections, suggesting next steps, and drafting response proposals. Policy controls decide what can actually happen.

## Agent Roles

| Agent | Purpose | Output |
|---|---|---|
| Detection Agent | Explains why a detection matched and what behavior it represents | Detection explanation, ATT&CK mapping, false-positive considerations |
| Triage Agent | Reviews tenant-scoped evidence and builds an incident narrative | Summary, confidence, affected entities, evidence references |
| Response Recommendation Agent | Suggests response actions based on evidence and expected impact | Structured agent proposal with action, scope, risk, and rollback notes |
| Policy Evaluation Agent | Prepares the proposal context for deterministic policy evaluation | Policy input package, required fields, approval routing context |
| Verification Agent | Checks whether an approved action achieved the intended outcome | Verification result, residual risk, rollback recommendation |
| Reporting Agent | Converts the full lifecycle into a reviewer-friendly incident report | Executive summary, timeline, decisions, evidence, lessons learned |

## Workflow

1. A finding is created by detection or correlation logic.
2. The Detection Agent explains the rule match and maps it to likely attacker behavior.
3. The Triage Agent retrieves tenant-scoped evidence from the timeline, entity graph, and evidence vault.
4. The Triage Agent summarizes what is known, what is uncertain, and which entities appear affected.
5. The Response Recommendation Agent drafts a structured proposal with action type, scope, expected impact, risk score, evidence references, and rollback plan.
6. The proposal is submitted to deterministic policy evaluation.
7. Policy returns allow, deny, or require approval.
8. Approved actions are executed by scoped playbooks and actuators, not by the agent directly.
9. The Verification Agent evaluates the outcome and triggers rollback guidance if needed.
10. The Reporting Agent creates a final audit-ready summary.

## AI Output Contract

Agent output should include:

- finding summary,
- confidence and uncertainty,
- evidence references,
- affected users, endpoints, and cloud resources,
- ATT&CK mapping when relevant,
- recommended action,
- expected blast radius,
- rollback plan,
- policy and approval status.

## Governance Boundary

The important boundary is that probabilistic reasoning does not become the source of authority. Agents can recommend a host isolation, session revocation, alert suppression, or policy change, but the proposal must pass policy checks and approval gates before any mutation is executed.

This is the difference between AI-assisted response and uncontrolled automation. The agent accelerates investigation. The policy layer owns authorization.
