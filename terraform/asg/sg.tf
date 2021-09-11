

resource "aws_security_group" "sg-allow-http" {
  name        = "sg-allow-http"
  description = "Allow HTTP inbound connections"
  vpc_id      = var.VPC_ID

  ingress = [{
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow 80 port"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    self        = false
  }]

  egress = [{
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }]

}
