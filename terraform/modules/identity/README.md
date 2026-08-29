# Identity module

This module is an RBAC and managed-identity placeholder, not a full Entra ID tenant build-out.

## What it creates

- A user-assigned managed identity for workloads (no stored VM passwords or long-lived client secrets in Terraform).
- A custom Azure RBAC role scoped to the lab resource groups, narrower than built-in Network Contributor.
- Optional role assignments to existing Entra ID groups (object IDs you supply).
- Optional Entra ID security groups, off by default so `validate` / a cautious `plan` does not create tenant objects.

## What it does not create

Conditional Access and Privileged Identity Management (PIM) are tenant-wide Entra ID controls. They typically require Entra ID P1/P2 and can affect every user in the directory. They are documented in the root README as out-of-band controls that sit on top of this RBAC model — they are not applied by this module.

That is an honest gap relative to a production zero-trust identity program, and it is intentional for a portfolio lab.
