provider "aws" {
  # Configuration options
  region = "us-west-2"
}

module "my_vpc" {
  source = "./modules/vpc"
  # Pass all the input to the module here, received by module as variables
  vpc_cidr_block = var.vpc_cidr_block
  priv_subnet_cidr_blocks = var.priv_subnet_cidr_blocks
  pub_subnet_cidr_blocks = var.pub_subnet_cidr_blocks
  name_prefix = local.name_prefix
  common_tags = local.common_tags
  cluster_name = local.cluster_name
}

module "my_eks" {
  source = "./modules/eks"
  name_prefix = local.name_prefix
  common_tags = local.common_tags
  cluster_name = local.cluster_name
  vpc_id = module.my_vpc.vpc_id
  private_subnets = module.my_vpc.private_subnets
}
