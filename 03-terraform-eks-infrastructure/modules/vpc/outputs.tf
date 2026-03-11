output "vpc_id" {
  value = module.my_vpc.vpc_id
}

output "private_subnets" {
  value = module.my_vpc.private_subnets
}

output "azs_used" {
  value = module.my_vpc.azs
}