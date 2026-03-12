provider "aws" {
  region = "us-west-2"
}

module "vpc" {
  source = "./modules/vpc"
  # Pass all the input to the module here, received by module as variables
  vpc_cidr_block = var.vpc_cidr_block
  pub_subnet_cidr_blocks = var.pub_subnet_cidr_blocks
  name_prefix = local.name_prefix
  common_tags = local.common_tags
}


module "jenkins_server" {
  source = "./modules/server"
  az = var.az
  env    = var.env
  instance_type = var.instance_type
  ssh_key_path = var.ssh_key_path
  vpc_id = module.vpc.vpc_id
  subnet_id = module.vpc.public_subnets[0]
}
