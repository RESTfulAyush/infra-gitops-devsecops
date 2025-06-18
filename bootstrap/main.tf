provider "aws" {
  region = var.aws_region
}

resource "aws_s3_bucket" "tf_backend" {
  bucket        = var.bucket_name
  force_destroy = true

  tags = {
    Name        = "Terraform State Bucket"
    Environment = "bootstrap"
  }
}

resource "aws_dynamodb_table" "tf_locks" {
  name         = var.lock_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "Terraform Lock Table"
    Environment = "bootstrap"
  }
}
