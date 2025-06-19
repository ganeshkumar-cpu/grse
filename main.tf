provider "aws" {
  region = "ap-south-1"
}

module "grse_vpc" {
  source     = "./modules/vpc"
  name       = "GRSE-vpc"
  cidr_block = "10.40.0.0/16"

  public_subnets = [
    { cidr_block = "10.40.101.0/24", availability_zone = "ap-south-1a" },
    { cidr_block = "10.40.102.0/24", availability_zone = "ap-south-1b" }
  ]

  private_subnets = [
    { cidr_block = "10.40.11.0/24", availability_zone = "ap-south-1a" },
    { cidr_block = "10.40.12.0/24", availability_zone = "ap-south-1b" }
  ]
}

resource "aws_security_group" "grse_sg" {
  name        = "GRSE-SG"
  description = "Allow SSH inbound"
  vpc_id      = module.grse_vpc.vpc_id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Open to all (consider restricting)
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

module "grse_instance" {
  source             = "./modules/ec2"
  name               = "GRSE-APP&DB"
  ami                = "ami-0f58c8c41c0f44f06"
  instance_type      = "t4g.2xlarge"
  key_name           = "GRSE-key"
  subnet_id          = module.grse_vpc.public_subnet_ids[0]  # Launch in first public subnet
  security_group_ids = [aws_security_group.grse_sg.id]
  root_volume        = 30
}
