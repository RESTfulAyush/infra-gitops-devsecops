terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.27"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.13"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# ─────────────────────────────────────────────
# 1. VPC Module
# ─────────────────────────────────────────────
module "vpc" {
  source = "../../modules/vpc"

  env                 = "dev"
  vpc_cidr            = "10.0.0.0/16"
  public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
  availability_zones  = ["us-east-1a", "us-east-1b"]
}

# ─────────────────────────────────────────────
# 2. IAM Module (for EKS cluster + node roles)
# ─────────────────────────────────────────────
module "iam" {
  source = "../../modules/iam"
  env    = "dev"
}

# ─────────────────────────────────────────────
# 3. EKS Module
# ─────────────────────────────────────────────
module "eks" {
  source = "../../modules/eks"

  env                     = "dev"
  subnet_ids              = module.vpc.public_subnets
  kubernetes_version      = "1.29"
  eks_cluster_role_arn    = module.iam.eks_cluster_role_arn
  eks_node_group_role_arn = module.iam.eks_node_role_arn
}

# ─────────────────────────────────────────────
# 4. CI IAM Role for GitHub Actions
# ─────────────────────────────────────────────
module "ci_iam" {
  source = "../../modules/ci-iam"

  env  = "dev"
  repo = "https://github.com/RESTfulAyush/task-flow.git"
}

# ─────────────────────────────────────────────
# 5. ECR Repo
# ─────────────────────────────────────────────
module "ecr" {
  source = "../../modules/ecr"
  env    = "dev"
}

# ─────────────────────────────────────────────
# 6. Argo CD Helm Install
# ─────────────────────────────────────────────
module "argocd" {
  source = "../../modules/argocd"
}

# ─────────────────────────────────────────────
# 7. Providers for Kubernetes & Helm
# ─────────────────────────────────────────────
provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}
