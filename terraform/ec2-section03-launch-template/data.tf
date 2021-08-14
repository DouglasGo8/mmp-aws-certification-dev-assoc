
data "aws_security_group" "sg-web-api" {
  id = var.SG_WEB_API
}

data "aws_security_group" "sg-ssh" {
  id = var.SG_SSH
}

data "aws_subnet" "main-public-1" {
  id = var.PUB_SUBNET_1
}
