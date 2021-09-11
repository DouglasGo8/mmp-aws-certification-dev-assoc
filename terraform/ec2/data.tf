data "aws_ami" "amzn2" {
  most_recent = true

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"] # regex-expression
  }
  owners = ["amazon"]
}


data "aws_subnet" "main-public-1" {
  id = "subnet-0a89dbf36b1230f6c"
}


data "aws_security_group" "sg-ssh" {
  id = "sg-07058b3144d231b3d"

}

data "aws_availability_zones" "available" {}
