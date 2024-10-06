# Destroy VPC resources
cd terragrunt\environments\development\vpc
Write-Host "Destroying VPC resources..."
terragrunt destroy --terragrunt-non-interactive

# Destroy EKS resources
cd ..\eks
Write-Host "Destroying EKS resources..."
terragrunt destroy --terragrunt-non-interactive

# Destroy Database resources
cd ..\database
Write-Host "Destroying Database resources..."
terragrunt destroy --terragrunt-non-interactive
