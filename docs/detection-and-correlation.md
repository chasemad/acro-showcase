# Detection And Correlation

ACRO uses normalized events and Sigma-style detection logic to keep detection content portable, explainable, and reviewable. The goal is to show how detection engineering fits into a governed response workflow, not to publish production detection content.

## Normalized Events

Telemetry is normalized into an OCSF-style event contract before detection rules, timelines, graph projection, or AI-assisted triage consume it. Normalized fields make it possible to write one rule against consistent concepts such as:

- `tenant_id`
- `event.category`
- `event.type`
- `actor.user.name`
- `actor.user.uid`
- `src_endpoint.ip`
- `device.hostname`
- `cloud.account.uid`
- `finding.severity`
- `metadata.product.name`

This avoids hard-coding vendor-specific field names into every detection and lets the same evidence appear consistently in dashboards, timelines, and audit receipts.

## Correlation Logic

Single alerts rarely tell the full story. ACRO-style correlation links events across:

- identity signals, such as unusual admin login or MFA changes,
- endpoint signals, such as suspicious process launches or host isolation state,
- cloud signals, such as IAM policy changes or sensitive API calls,
- time windows, such as escalation followed by data access,
- entity relationships, such as a user owning a session on a host that can reach a sensitive resource.

Correlation output should explain both the triggering evidence and the relationship between events.

## Severity Scoring

Severity is derived from a combination of detection confidence, asset criticality, identity privilege, blast radius, and response urgency. A suspicious admin escalation on a low-risk test account should not receive the same priority as the same event on a privileged cloud administrator tied to production resources.

Severity is a triage signal, not a replacement for analyst judgment.

## MITRE ATT&CK Mapping

Detection examples include MITRE ATT&CK technique tags where relevant. The mapping helps reviewers understand which behavior class the rule is intended to detect and how it fits into broader coverage planning.

Example tags:

- `attack.t1078` for valid accounts,
- `attack.t1098` for account manipulation,
- `attack.t1556` for modify authentication process,
- `attack.t1550` for use of stolen or replayed credentials.

## False-Positive Notes

Each detection should document likely benign sources. Examples include scheduled admin maintenance, identity provider migrations, helpdesk account recovery, trusted travel, lab systems, and break-glass access tests.

False-positive notes are not filler. They help analysts tune rules safely and explain why a finding should or should not escalate.

## Example Detection Workflow

1. An identity event shows a privileged account logging in from a new country.
2. A second event shows admin role membership added within the correlation window.
3. The detection engine matches a Sigma-style rule against normalized fields.
4. Correlation links the identity, session, source IP, target account, and affected cloud resources.
5. The incident workspace displays the timeline, evidence references, severity, and ATT&CK mapping.
6. The AI-assisted triage layer summarizes the evidence and proposes next steps.
7. Policy decides whether session revocation, host isolation, or escalation is allowed.
