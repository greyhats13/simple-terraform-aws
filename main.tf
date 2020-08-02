provider "aws" {
  region     = var.region
  profile    = var.profile
  access_key = var.aws_access_key_id
  secret_key = var.aws_secret_access_key
}

module "vpc" {
  source = "./vpc"
}

module "ec2" {
  source       = "./ec2"
  vpc_id       = module.vpc.vpc_id
  nodes_subnet = flatten([module.vpc.nodes_subnet])
}
