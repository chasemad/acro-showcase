package acro.governance.response

default decision := {
  "effect": "deny",
  "reason": "No matching allow rule"
}

high_risk_actions := {
  "identity.revoke_sessions",
  "identity.disable_user",
  "endpoint.isolate_host",
  "cloud.policy_patch",
  "network.block_range"
}

risk_threshold := 70

decision := {
  "effect": "deny",
  "reason": "tenant_id is required for every response action"
} if {
  not input.tenant_id
}

decision := {
  "effect": "deny",
  "reason": "rollback plan is required for response action"
} if {
  input.tenant_id
  not input.rollback_plan
}

decision := {
  "effect": "deny",
  "reason": "evidence references are required for response action"
} if {
  input.tenant_id
  count(input.evidence_refs) == 0
}

decision := {
  "effect": "require_approval",
  "reason": "high-risk action requires manual approval above risk threshold"
} if {
  input.tenant_id
  high_risk_actions[input.action.type]
  input.risk_score >= risk_threshold
  not input.approval.approved
}

decision := {
  "effect": "allow",
  "reason": "high-risk action has tenant scope, evidence, rollback plan, and manual approval"
} if {
  input.tenant_id
  high_risk_actions[input.action.type]
  input.approval.approved == true
  input.rollback_plan
  count(input.evidence_refs) > 0
}

decision := {
  "effect": "allow_with_guardrails",
  "reason": "risk is below threshold and required safety context is present",
  "guardrails": {
    "audit_required": true,
    "max_scope": "single_entity"
  }
} if {
  input.tenant_id
  input.risk_score < risk_threshold
  input.rollback_plan
  count(input.evidence_refs) > 0
}
