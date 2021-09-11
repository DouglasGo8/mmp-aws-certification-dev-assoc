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
  id = "subnet-022edc9ec0dddc6a9"
}

data "aws_subnet" "main-public-2" {
  id = "subnet-0ed44b629ea9baba4"
}

data "aws_subnet" "main-public-3" {
  id = "subnet-0b8b5db1169d48c57"
}
