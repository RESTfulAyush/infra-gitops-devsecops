variable "aws_region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "bucket_name" {
  description = "Name of the S3 bucket for Terraform state"
}

variable "lock_table_name" {
  description = "Name of the DynamoDB table for Terraform state locking"
}
