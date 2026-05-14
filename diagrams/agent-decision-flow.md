# Agent Decision Flow

This flow highlights the agent boundary. Agents can investigate, explain, and propose. The proposal becomes actionable only after deterministic policy evaluation and approval routing.

```mermaid
flowchart TB
    FINDING["Finding Created<br/>normalized event + rule match"]
    DETECT["Detection Agent<br/>explain behavior"]
    TRIAGE["Triage Agent<br/>retrieve evidence"]
    CONTEXT["Context Pack<br/>timeline, graph, evidence refs"]
    REC["Response Recommendation Agent<br/>draft action proposal"]
    PROPOSAL["Structured Agent Proposal<br/>scope + rationale + rollback"]
    POLICY{{"Policy Check<br/>tenant, risk, evidence, rollback"}}
    ALLOW["Allow<br/>low risk within guardrails"]
    ESCALATE["Require Approval<br/>high risk or broad scope"]
    DENY["Deny<br/>unsafe or incomplete"]
    HUMAN["Analyst Review<br/>approve, reject, modify"]
    EXECUTE[["Execute Approved Playbook"]]
    VERIFY["Verification Agent<br/>confirm outcome"]
    REPORT["Reporting Agent<br/>audit-ready summary"]

    FINDING --> DETECT --> TRIAGE --> CONTEXT --> REC --> PROPOSAL --> POLICY
    POLICY --> ALLOW --> EXECUTE
    POLICY --> ESCALATE --> HUMAN --> EXECUTE
    POLICY --> DENY --> REPORT
    EXECUTE --> VERIFY --> REPORT
    CONTEXT --> REPORT

    classDef finding fill:#e0f2fe,stroke:#0284c7,color:#0c4a6e
    classDef agent fill:#ede9fe,stroke:#7c3aed,color:#3b0764
    classDef proposal fill:#fef3c7,stroke:#d97706,color:#78350f
    classDef policy fill:#fee2e2,stroke:#dc2626,color:#7f1d1d
    classDef response fill:#cffafe,stroke:#0891b2,color:#164e63
    classDef report fill:#f8fafc,stroke:#475569,color:#0f172a

    class FINDING finding
    class DETECT,TRIAGE,REC,VERIFY,REPORT agent
    class CONTEXT,PROPOSAL proposal
    class POLICY,ALLOW,ESCALATE,DENY,HUMAN policy
    class EXECUTE response
```
