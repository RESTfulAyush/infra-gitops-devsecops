# This file must not use variables — Terraform backend configs only allow hardcoded values.

terraform {
  backend "s3" {
    bucket         = "ayush-remote-backend1206"
    key            = "eks/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
