variable "vpc_cidr" {
  default     = "10.0.0.0/16"
  description = "CIDR for the VPC"
}

variable "public_subnet_cidrs" {
  description = "List of public subnet CIDRs"
  type        = list(string)
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
}

variable "env" {
  description = "Environment name (e.g., dev)"
  type        = string
}
