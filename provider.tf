provider "aws" {
  region = locals.region 
}

terraform {
  backend "s3" {
    bucket = "l4-cloud-terraform-state"
    key    = "portfolio/terraform.tfstate"
    region = locals.region 
  }
}
