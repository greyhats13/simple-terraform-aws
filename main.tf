provider "aws" {
  region  = var.region
  profile = var.profile
}

module "vpc" {
  source = "./vpc"
}

module "ec2" {
  source       = "./ec2"
  vpc_id       = module.vpc.vpc_id
  nodes_subnet = module.vpc.nodes_subnet
}

terraform {
  required_version = ">= 0.12"
}
