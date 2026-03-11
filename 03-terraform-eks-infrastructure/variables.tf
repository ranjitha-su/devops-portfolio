variable "vpc_cidr_block" {
  type = string
}

variable "priv_subnet_cidr_blocks" {
  type = list(string)
}

variable "pub_subnet_cidr_blocks" {
  type = list(string)
}

variable "env" {
  type = string
}
