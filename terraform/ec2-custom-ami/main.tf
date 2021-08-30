
resource "aws_instance" "t2-nano-inst" {
  ami = data.aws_ami.centos.id
  instance_type = "t2.nano" // no free tier
  key_name = aws_key_pair.pub-key.key_name

  tags = {
    Name = "aws-dev-cert-assoc-quarkus-camel-rest-ec2"
  }

}


resource "aws_key_pair" "pub-key" {
  key_name = "key-pub"
  public_key = file("../../.secret/key.pub")
}