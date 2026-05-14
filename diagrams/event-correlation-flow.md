# Event Correlation Flow

This flow shows how separate signals become a single incident narrative. Correlation links identity, endpoint, and cloud events before an agent drafts a response recommendation.

```mermaid
flowchart LR
    subgraph RAW["Incoming Signals"]
        LOGIN["Identity Login<br/>new country"]
        MFA["MFA Change<br/>new factor"]
        ROLE["Admin Role Added"]
        HOST["Endpoint Session<br/>new device"]
        API["Cloud API Call<br/>sensitive read"]
    end

    subgraph NORM["Normalize And Enrich"]
        MAP["Map To Common Fields"]
        ENRICH["Add Tenant, Asset, User, Geo, Risk"]
        BUS[("Normalized Event Bus")]
    end

    subgraph DETECT["Detection And Correlation"]
        RULE1["Impossible Travel Rule"]
        RULE2["Admin Escalation Rule"]
        WINDOW["Correlation Window<br/>30 minutes"]
        INCIDENT["Correlated Incident"]
    end

    subgraph OUT["Investigation Output"]
        TIMELINE["Timeline"]
        ENTITIES["Linked Entities"]
        EVIDENCE["Evidence Refs"]
        TRIAGE["AI-Assisted Triage"]
    end

    LOGIN --> MAP
    MFA --> MAP
    ROLE --> MAP
    HOST --> MAP
    API --> MAP
    MAP --> ENRICH --> BUS
    BUS --> RULE1 --> WINDOW
    BUS --> RULE2 --> WINDOW
    BUS --> WINDOW --> INCIDENT
    INCIDENT --> TIMELINE
    INCIDENT --> ENTITIES
    INCIDENT --> EVIDENCE
    TIMELINE --> TRIAGE
    ENTITIES --> TRIAGE
    EVIDENCE --> TRIAGE

    classDef raw fill:#e0f2fe,stroke:#0284c7,color:#0c4a6e
    classDef norm fill:#dcfce7,stroke:#16a34a,color:#14532d
    classDef detect fill:#fef3c7,stroke:#d97706,color:#78350f
    classDef output fill:#ede9fe,stroke:#7c3aed,color:#3b0764

    class LOGIN,MFA,ROLE,HOST,API raw
    class MAP,ENRICH,BUS norm
    class RULE1,RULE2,WINDOW,INCIDENT detect
    class TIMELINE,ENTITIES,EVIDENCE,TRIAGE output
```
