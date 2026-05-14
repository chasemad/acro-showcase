# Blast Radius Flow

Blast-radius analysis connects a finding to the people, systems, privileges, and business services that could be affected. The goal is not a bigger graph. The goal is a better response decision.

```mermaid
flowchart TB
    FINDING["Finding<br/>admin escalation"]
    IDENTITY["Identity<br/>admin.demo@example.test"]
    SESSION["Session<br/>new geo + device"]
    HOST["Endpoint<br/>host-demo-01"]
    ROLE["Privileged Role<br/>cloud-admin-demo"]
    CLOUD["Cloud Resources<br/>prod-like demo assets"]
    SERVICE["Business Service<br/>demo billing portal"]
    RESPONSE["Candidate Response<br/>revoke session or isolate host"]
    SCORE["Blast Radius Score<br/>scope + criticality + reversibility"]
    DECISION["Response Decision<br/>policy route + analyst context"]

    FINDING --> IDENTITY
    IDENTITY --> SESSION
    SESSION --> HOST
    IDENTITY --> ROLE
    ROLE --> CLOUD
    CLOUD --> SERVICE
    HOST --> SERVICE
    FINDING --> RESPONSE
    IDENTITY --> SCORE
    HOST --> SCORE
    CLOUD --> SCORE
    SERVICE --> SCORE
    RESPONSE --> SCORE --> DECISION

    classDef alert fill:#fef3c7,stroke:#d97706,color:#78350f
    classDef entity fill:#e0f2fe,stroke:#0284c7,color:#0c4a6e
    classDef impact fill:#fee2e2,stroke:#dc2626,color:#7f1d1d
    classDef decision fill:#dcfce7,stroke:#16a34a,color:#14532d

    class FINDING alert
    class IDENTITY,SESSION,HOST,ROLE entity
    class CLOUD,SERVICE,RESPONSE,SCORE impact
    class DECISION decision
```
