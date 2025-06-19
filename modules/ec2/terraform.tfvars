ec2_instances = {
  "test-instance" = {
    ami           = "ami-0abcd1234abcd5678"
    instance_type = "t3.micro"
    root_volume   = 20
  }
}

subnet_map = {
  "test-instance" = "subnet-0123456789abcdef0"
}

sg_map = {
  "test-instance" = ["sg-0123456789abcdef0"]
}

key_name = "your-key-name"

