terraform {
  required_version = "~> 1.0.3"
}


resource "aws_instance" "t2-micro-inst" {
  ami                    = data.aws_ami.amzn2.id
  subnet_id              = data.aws_subnet.main-public-1.id
  vpc_security_group_ids = [data.aws_security_group.sg-ssh.id, aws_security_group.sg-allow-http.id]
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.key-pub.key_name
  user_data              = filebase64("./httpd.sh")
  availability_zone      = data.aws_availability_zones.available.names[0]


}

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

resource "aws_key_pair" "key-pub" {
  key_name   = "key-pub"
  public_key = file("../.secret/key.pub")
}
