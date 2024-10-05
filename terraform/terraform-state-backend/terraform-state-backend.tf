
provider "aws" {
  region = "eu-west-2"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "terraform-state-project05102024"

  tags = {
    Name        = "terraform-state-project05102024"
    Environment = "development"
  }
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
  billing_mode = "PAY_PER_REQUEST"
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

terraform {
  backend "s3" {
    region         = "eu-west-2"
    bucket         = "terraform-state-project05102024"
    key            = "terraform.tfstate"
    encrypt        = true
    dynamodb_table = "terraform-state-lock"
  }
}
