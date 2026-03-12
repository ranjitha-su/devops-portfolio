// Declare the data source
data "aws_availability_zones" "zones_for_my_region" {
  state = "available"
}

// Download the aws vpc module and use the following custom configuration
module "my_vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "6.5.1"

  name = "${var.name_prefix}-vpc"
  cidr = var.vpc_cidr_block

  // slice the az list to length 2, so it match with the subnet cidr block length. Then AWS makes sure the subnets are
  // disctributed across azs for HA.
  azs             = slice(data.aws_availability_zones.zones_for_my_region.names, 0, 2)
  public_subnets  = var.pub_subnet_cidr_blocks

  enable_dns_hostnames = true

  tags = var.common_tags

  public_subnet_tags = {
    Name = "${var.name_prefix}-public-subnet"
    "kubernetes.io/role/elb" = 1
  }
}