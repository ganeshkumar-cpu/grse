resource "aws_instance" "this" {
  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = var.security_group_ids
  key_name                    = var.key_name
  associate_public_ip_address = true
  monitoring                  = false

  tags = {
    Name = var.name
  }

  root_block_device {
    volume_type = "gp3"
    volume_size = var.root_volume
  }
}

