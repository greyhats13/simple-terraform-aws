provider "aws" {
  region     = var.region
  profile    = var.profile
  access_key = var.access_key
  secret_key = var.secret_key
}

module "vpc" {
  source = "./vpc"
}

module "ec2" {
  source       = "./ec2"
  vpc_id       = module.vpc.vpc_id
  nodes_subnet = flatten([module.vpc.nodes_subnet])
}
