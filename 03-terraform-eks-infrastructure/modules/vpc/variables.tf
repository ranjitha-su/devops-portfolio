variable "vpc_cidr_block" {
  type = string
}

variable "priv_subnet_cidr_blocks" {
  type = list(string)
  description = "cidr blocks for private subnet"
}

variable "pub_subnet_cidr_blocks" {
  type = list(string)
  description = "cidr blocks for public subnet"
}

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
