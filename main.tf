provider "aws" {
  region = "ap-south-1"
}

# VPC module
module "grse_vpc" {
  source            = "./modules/vpc"
  name              = "GRSE-vpc"
  cidr_block        = "10.40.0.0/16"
  subnet_cidr       = "10.40.1.0/24"
  availability_zone = "ap-south-1a"
}

# Create Security Group allowing SSH (port 22) inbound
resource "aws_security_group" "grse_sg" {
  name        = "GRSE-SG"
  description = "Allow SSH inbound"
  vpc_id      = module.grse_vpc.vpc_id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Change this to your IP range for better security
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "GRSE-SG"
  }
}

# EC2 instance module, now using the created security group
module "grse_instance" {
  source             = "./modules/ec2"
  name               = "GRSE-APP&DB"
  ami                = "ami-0f58c8c41c0f44f06"
  instance_type      = "t4g.2xlarge"
  key_name           = "GRSE-key"
  subnet_id          = module.grse_vpc.subnet_id
  security_group_ids = [aws_security_group.grse_sg.id]  # Use created security group here
  root_volume        = 30
}

