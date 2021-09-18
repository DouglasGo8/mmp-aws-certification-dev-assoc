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

data "aws_subnet" "main-public-2" {
  id = "subnet-0a3f3a2ccda973b07"
}

data "aws_subnet" "main-public-3" {
  id = "subnet-0214d67d90219273d"
}
