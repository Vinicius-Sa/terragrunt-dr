# Generated by Terragrunt. Sig: nIlQXj57tbuaRZEa
terraform {
  backend "s3" {
    bucket = "symplicity-terraform-state"
    key    = "dev/us-east-1/ami/terraform.tfstate"
    region = "us-east-1"
  }
}