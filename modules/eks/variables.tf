variable "env" {
  type        = string
  description = "Environment name (e.g., dev)"
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnets to attach the EKS cluster to"
}

variable "kubernetes_version" {
  type        = string
  default     = "1.29"
  description = "Kubernetes version for EKS"
}

variable "eks_cluster_role_arn" {
  type        = string
  description = "IAM role ARN for the EKS control plane"
}

variable "eks_node_group_role_arn" {
  type        = string
  description = "IAM role ARN for worker nodes"
}
