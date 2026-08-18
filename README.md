# Portfolio Projects

This document contains 3 enterprise-grade, portfolio-ready project concepts tailored for Cloud, Systems, and Network Infrastructure Engineers. Each project is designed to showcase production standards, Infrastructure as Code (IaC), zero-trust security, and automated workflows.

---

## Project 1: Multi-Region Azure Hybrid Infrastructure & Zero Trust Identity

### Overview
A production-ready Infrastructure-as-Code (IaC) repository that provisions a secure, highly available Azure enterprise environment connected to on-premises resources via encrypted site-to-site networking.

### Key Features
* **IaC Automation:** Modular Terraform scripts provisioning Azure VNets, Subnets, Network Security Groups (NSGs), and NAT Gateways.
* **Identity & Governance:** Entra ID Conditional Access policies, Role-Based Access Control (RBAC), and Privileged Identity Management (PIM) integration.
* **Secure Hybrid Connectivity:** Virtual Network Gateways with IPsec VPN tunnel configurations for hybrid infrastructure.
* **Monitoring & Security:** Centralized Azure Monitor workspace, Log Analytics, and Defender for Cloud integration.

### Repository Structure
```text
azure-enterprise-infrastructure/
├── terraform/
│   ├── modules/
│   │   ├── networking/
│   │   ├── identity/
│   │   └── compute/
│   ├── environments/
│   │   ├── prod/
│   │   └── dev/
│   ├── main.tf
│   ├── variables.tf
│   └── outputs.tf
├── .github/
│   └── workflows/
│       ├── terraform-lint.yml
│       └── terraform-plan.yml
├── docs/
│   └── architecture-diagram.png
└── README.md
