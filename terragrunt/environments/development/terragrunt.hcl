remote_state {
  backend = "s3"
  generate = {
    path = "terraform-state.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket = "terraform-state-project05102024"
    key = "stage/${path_relative_to_include()}/terraform.tfstate"
    region = "eu-west-2"
    encrypt = true
  }
}

generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
provider "aws" {
  region  = "eu-west-2"
  assume_role {
    role_arn = local.iam_state.eks_cluster_role.arn
  }
}
EOF
}

generate "locals" {
  path = "state.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
data "terraform_remote_state" "iam" {
  backend = "s3"
  config = {
    region = "eu-west-2"
    bucket = "terraform-state-project05102024"
    key    = "iam/terraform.tfstate"
  }
}
EOF
}
