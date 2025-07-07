
# FlipCoin – Infrastructure as Code (Terraform)

This repository defines and provisions the entire AWS infrastructure required for the **FlipCoin** application using **Terraform**, following modular and production-ready DevSecOps practices.

---

## 📌 Problem Statement

Our goal was to create a scalable, secure, and fully automated infrastructure to support GitOps and CI/CD workflows for the FlipCoin application. Key requirements included:

- An **EKS cluster** to run the app on Kubernetes
- **OIDC integration** with GitHub Actions for secure deployments
- An **ECR repository** for storing Docker images
- **Argo CD installation and bootstrap** via Terraform
- A modular and reusable architecture with clear separation of concerns

---

## 🧱 Repository Structure

```text
infra-gitops-devsecops/
├── bootstrap/                  # Bootstrap layer to apply initial Terraform state
├── environments/              # Placeholder for per-environment variables (future extension)
├── modules/                   # Reusable Terraform modules
│   ├── argocd/                # Helm-based Argo CD setup
│   ├── ci-iam/                # GitHub OIDC IAM role for CI/CD
│   ├── ecr/                   # ECR Docker image repository
│   ├── eks/                   # EKS cluster and node group
│   ├── iam/                   # IAM roles/policies for EKS and workers
│   └── vpc/                   # VPC, subnets, and internet gateway
├── backend.tf                 # Remote state configuration
├── main.tf                    # Root Terraform config importing modules
├── provider.tf                # AWS provider configuration
├── variables.tf               # Root input variables
├── outputs.tf                 # Output values (e.g., EKS cluster info)
├── terraform.tfvars           # Actual variable values
└── tfplan                     # Terraform plan file (optional, local use)
````

---

## 🛠️ Challenges Faced

* Designing clean, reusable **Terraform modules** for each infrastructure concern (networking, compute, IAM, etc.)
* Setting up **OIDC trust between GitHub Actions and AWS IAM** securely for role assumption
* Installing **Argo CD via Helm** within Terraform with proper idempotency
* Coordinating outputs from multiple modules to feed into each other (e.g., VPC → EKS → Argo CD)
* Managing separation between **bootstrap** and **main** infrastructure for better lifecycle management

---

## ✅ Outcome

* A complete infrastructure stack for GitOps + DevSecOps pipelines, managed entirely through Terraform
* EKS cluster up and running with properly scoped IAM roles
* Docker image hosting via ECR
* Argo CD installed and configured via Helm through Terraform
* GitHub Actions integrated with AWS via OIDC for secure, tokenless deployments
* Fully modular structure that can be reused or extended for future environments like `prod`, `staging`, or additional microservices

---

## 🔗 Related Repositories

* 💻 [FlipCoin Code & CI/CD Repository](https://github.com/RESTfulAyush/flipCoin.git)
* 📦 [GitOps Environments Repository](https://github.com/RESTfulAyush/gitops-environments.git)
