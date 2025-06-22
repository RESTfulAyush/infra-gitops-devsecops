terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
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

module "ci_iam" {
  source = "../../modules/ci-iam"

  env  = "dev"
  repo = "https://github.com/RESTfulAyush/task-flow.git" # 🔁 replace this with your actual repo
}

module "ecr" {
  source = "../../modules/ecr"
  env    = "dev"
}

module "argocd" {
  source = "../../modules/argocd"
}

module "argocd" {
  source = "../../modules/argocd"
}

