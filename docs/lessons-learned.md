# Lessons Learned

The strongest design lesson from ACRO is that autonomy is not the same as authority. AI-assisted systems can help analysts move faster, but deterministic controls must decide which actions are allowed.

## AI Should Assist, Not Bypass Controls

AI is useful for summarizing evidence, explaining detections, connecting timelines, identifying affected entities, and drafting response recommendations. It should not directly mutate protected systems.

The safe boundary is simple: agents produce structured proposals; policy and approval workflows decide what happens next.

## Policy Engines Should Govern Response

Response safety should not be hidden inside application code or prompt instructions. Policy-as-code makes response rules inspectable, testable, versioned, and explainable.

Policy should evaluate tenant scope, action risk, evidence quality, approval state, rollback plan, autonomy level, and kill-switch status.

## Auditability Matters

Auditability is not just a compliance checkbox. It is how analysts, managers, and reviewers build trust in automated workflows.

A useful audit trail captures the finding, evidence, agent proposal, policy input, policy output, approval status, execution result, verification result, rollback status, and final receipt.

## Graph Analysis Is Useful Where Relationships Matter

Graphs are valuable when they explain paths, dependencies, and blast radius. They are less useful when they become a second copy of raw telemetry.

The best use is curated relationship modeling: identities, assets, sessions, roles, cloud resources, vulnerabilities, findings, and response targets.

## Safe Response Requires Rollback Planning

Every meaningful response action should answer two questions before execution:

- How will we know this worked?
- How will we reverse it if it causes unexpected impact?

Rollback planning turns response from a one-way command into a controlled lifecycle.

## Practical Tradeoffs

ACRO favors conservative governance over speed for high-risk actions. That adds friction, but it reduces the chance that a false positive or bad recommendation becomes an operational incident.

The design is intentionally documentation-first in this public repository. It demonstrates system design and security engineering judgment without exposing private implementation details.
