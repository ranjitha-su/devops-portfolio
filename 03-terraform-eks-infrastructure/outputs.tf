output "azs_used" {
  value = module.my_vpc.azs_used
}

output "eks_cluster_endpoint" {
  value = module.my_eks.cluster_endpoint
}

output "eks_cluster_name" {
  value = module.my_eks.cluster_name
}
