variable "name" {
  type        = string
  description = "Name prefix for VPC resources"
}

variable "cidr_block" {
  type        = string
  description = "CIDR block for the VPC"
}

variable "public_subnets" {
  type = list(object({
    cidr_block        = string
    availability_zone = string
  }))
}

variable "private_subnets" {
  type = list(object({
    cidr_block        = string
    availability_zone = string
  }))
}
