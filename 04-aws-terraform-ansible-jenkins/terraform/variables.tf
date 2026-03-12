variable az {
  type        = string
  default     = "us-west-2a"
  description = "availibility zone"
}


variable vpc_cidr_block {
  type        = string
  description = "vpc cidr block"
}

variable pub_subnet_cidr_blocks {
  type        = list(string)
  description = "public subnet cidr block"
}

variable "env" {
  type = string
  description = "current environment prefix"
}

variable "instance_type" {
  type = string
  description = "type of in instance in aws"
}

variable "ssh_key_path" {
  type = string
  description = "local path to ssh public key file that will be used to ssh into the ec2 instance"
}