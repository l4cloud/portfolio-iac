provider "aws" {
  region = "eu-west-1"
}

terraform {
  backend "s3" {
    bucket = "l4-cloud-terraform-state"
    key    = "portfolio/terraform.tfstate"
    region = "eu-west-1"
  }
}
