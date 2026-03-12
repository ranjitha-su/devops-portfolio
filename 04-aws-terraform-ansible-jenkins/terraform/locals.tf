locals {
  name_prefix = "${var.env}-jenkins"
  common_tags = {
    Terraform = "true"
    Environment = var.env
  }
}