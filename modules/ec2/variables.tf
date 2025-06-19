variable "name" {
  type        = string
  description = "Name tag for the instance"
}

variable "ami" {
  type        = string
  description = "AMI ID for the instance"
}

variable "instance_type" {
  type        = string
  description = "Instance type"
}

variable "key_name" {
  type        = string
  description = "EC2 key pair name"
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID to launch the instance in"
}

variable "security_group_ids" {
  type        = list(string)
  description = "List of security group IDs"
}

variable "root_volume" {
  type        = number
  default     = 30
  description = "Root volume size in GB"
}

