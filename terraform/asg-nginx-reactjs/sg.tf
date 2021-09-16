

resource "aws_security_group" "sg-allow-http" {
  name        = "sg_http"
  description = "Allow HTTP inbound connections"
  vpc_id      = var.VPC_ID

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow Http Connections"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Allow HTTP"
  }

}


resource "aws_security_group" "sg-allow-lb-http" {

  name   = "sg_allow_lb_http"
  vpc_id = var.VPC_ID

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }

}
