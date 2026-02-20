provider "aws" {
  region = "us-east-1"
}

# S3 Bucket for state file
resource "aws_s3_bucket" "s3_terraformstate" {
  bucket = "terraform-state-lara-project1"
  tags = {
    Name = "Terraform State Bucket Lara"
  }
}

# Enable versioning on the S3 bucket
resource "aws_s3_bucket_versioning" "terraform_state" {
  bucket = aws_s3_bucket.s3_terraformstate.id
  
  versioning_configuration {
    status = "Enabled"
  }
}

# Enable encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "s3_terraformstate" {
  bucket = aws_s3_bucket.s3_terraformstate.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Block public access
resource "aws_s3_bucket_public_access_block" "s3_terraformstate" {
  bucket = aws_s3_bucket.s3_terraformstate.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# DynamoDB table for state locking
resource "aws_dynamodb_table" "dyntb_terraform_locks" {
  name         = "terraform-state-locks-lara"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name = "Terraform State Lock Table Lara"
  }
}

# Output the values you'll need
output "s3_bucket_name" {
  value = aws_s3_bucket.s3_terraformstate.id
}

output "dynamodb_table_name" {
  value = aws_dynamodb_table.dyntb_terraform_locks.name
}