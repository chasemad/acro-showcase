# Response Governance Flow

This diagram shows the response lifecycle from proposal to audit. The policy firewall is deliberately placed before execution so high-risk actions cannot bypass governance.

```mermaid
flowchart LR
    SUGGEST["Suggest<br/>agent or analyst proposal"]
    SIM["Simulate<br/>impact and blast radius"]
    PACKAGE["Stage Proposal<br/>scope, evidence, rollback"]
    POLICY{{"Policy Check"}}
    DENY["Deny<br/>missing context or unsafe action"]
    APPROVAL{"Approval Needed?"}
    QUEUE["Approval Queue<br/>human review"]
    EXEC[["Execute<br/>scoped playbook"]]
    VERIFY["Verify<br/>outcome checks"]
    ROLLBACK{"Rollback Needed?"}
    REVERT["Rollback<br/>restore safe state"]
    RECEIPT[/"Audit Receipt<br/>decision + outcome"/]

    SUGGEST --> SIM --> PACKAGE --> POLICY
    POLICY --> DENY --> RECEIPT
    POLICY --> APPROVAL
    APPROVAL -- "yes" --> QUEUE --> EXEC
    APPROVAL -- "no" --> EXEC
    EXEC --> VERIFY --> ROLLBACK
    ROLLBACK -- "yes" --> REVERT --> RECEIPT
    ROLLBACK -- "no" --> RECEIPT

    classDef prep fill:#e0f2fe,stroke:#0284c7,color:#0c4a6e
    classDef policy fill:#fee2e2,stroke:#dc2626,color:#7f1d1d
    classDef exec fill:#dcfce7,stroke:#16a34a,color:#14532d
    classDef audit fill:#f8fafc,stroke:#475569,color:#0f172a

    class SUGGEST,SIM,PACKAGE prep
    class POLICY,DENY,APPROVAL,QUEUE policy
    class EXEC,VERIFY,ROLLBACK,REVERT exec
    class RECEIPT audit
```
