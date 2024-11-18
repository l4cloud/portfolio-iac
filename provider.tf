provider "aws" {
  region = "eu-west-1"
}

provider "aws" {
  region = "us-east-1"
  alias  = "ue1"
}

terraform {
  backend "s3" {
    bucket = "l4-cloud-terraform-state"
    key    = "portfolio/terraform.tfstate"
    region = "eu-west-1"
  }
}
