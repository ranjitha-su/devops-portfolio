variable "name_prefix" {
  type = string
}

variable "common_tags" {
  type = object({
    Terraform = bool
    Environment = string
  })
}

variable "cluster_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "private_subnets" {
  type = list(string)
}