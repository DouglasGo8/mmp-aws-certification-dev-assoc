data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = var.AMI_OWNERS
  # Canonical
}

# must be parametrized
data "aws_subnet" "main-public-1" {
  id = "subnet-0c9c4cff9ed96f5d7"
}

data "aws_subnet" "main-public-2" {
  id = "subnet-019c1fac2531e256b"
}

data "aws_subnet" "main-public-3" {
  id = "subnet-0727c466af51fb6b4"
}
