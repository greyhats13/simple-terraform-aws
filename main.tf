provider "aws" {
  shared_credentials_file = "./.aws/credentials"
  region  = var.region
  profile = var.profile
}

module "vpc" {
  source                  = "./vpc"
}