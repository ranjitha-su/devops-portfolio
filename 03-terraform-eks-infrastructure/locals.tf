locals {
  name_prefix = "${var.env}-eks"
  cluster_name = "${local.name_prefix}-cluster"
}

locals {
  common_tags = {
    Terraform = "true"
    Environment = var.env
  }
}