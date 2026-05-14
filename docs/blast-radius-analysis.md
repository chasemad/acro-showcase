# Blast-Radius Analysis

Blast-radius analysis estimates what could be affected by an incident or response action. In ACRO, this is modeled as a relationship problem across users, endpoints, cloud resources, sessions, privileges, findings, and business context.

## Entity Relationships

The graph model focuses on relationships that improve investigation:

- user owns session,
- session accessed endpoint,
- endpoint can reach cloud resource,
- identity has admin role,
- role grants permission,
- finding observed on entity,
- entity supports business service,
- response action targets entity.

The graph does not need every raw event. It needs curated relationships that make incident reasoning faster and safer.

## Affected Users

User impact is derived from direct and indirect relationships. A compromised admin identity may affect:

- active sessions,
- delegated permissions,
- service accounts it can manage,
- groups it can modify,
- resources it recently accessed.

The goal is to distinguish a single suspicious login from a broader identity-risk incident.

## Affected Endpoints

Endpoint impact considers:

- hosts touched by the identity,
- hosts sharing credentials or sessions,
- hosts with suspicious process or network activity,
- hosts connected to sensitive network zones,
- response impact if the host is isolated.

This helps avoid isolating a critical host without understanding downstream consequences.

## Affected Cloud Resources

Cloud impact considers:

- cloud accounts and projects,
- privileged roles,
- sensitive resources,
- policy changes,
- data access events,
- trust relationships between workloads.

The analysis should describe what is known from evidence and what remains uncertain.

## Risk Scoring

Risk scoring combines:

- severity of the detection,
- confidence in the evidence,
- privilege level of affected identities,
- criticality of affected assets,
- number and strength of graph paths,
- reversibility of the proposed response.

The output is a prioritization aid. It should not be presented as a mathematically perfect measure of business risk.

## Graph-Based Reasoning

Graph-based reasoning is useful when relationships materially change the decision. Examples include:

- a low-severity alert on a high-privilege identity,
- a suspicious host with access to sensitive cloud resources,
- an admin action that affects a broad group,
- a response action that could interrupt a critical service,
- a finding that connects to previous incidents through shared infrastructure.

Graph analysis should make the analyst faster and the response safer.
