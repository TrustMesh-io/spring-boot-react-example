
provider "aws" {
  region = "us-west-2"
  profile = "trustmesh-774305614360-AdministratorAccess"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "terraform-state-project05102024"

  tags = {
    Name = "terraform-state-project05102024"
    Environment = "development"
  }
}

resource "aws_s3_bucket_acl" "state_acl" {
  bucket = aws_s3_bucket.terraform_state.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.terraform_state.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Optional: Create a DynamoDB table for state locking and consistency
resource "aws_dynamodb_table" "terraform_locks" {
  name         = "terraform-state-lock"
  billing_mode = "PAY_PER_REQUEST"  # Auto-scaling pricing model
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "terraform-state-lock"
    Environment = "production"
  }
}

# Temporarily use a local backend for storing Terraform state
terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}
