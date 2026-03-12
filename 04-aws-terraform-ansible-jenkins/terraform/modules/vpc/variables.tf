variable "vpc_cidr_block" {
  type = string
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
