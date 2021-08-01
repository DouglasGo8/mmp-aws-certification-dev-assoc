terraform {
  required_version = "~> 1.0.3"
}

resource "aws_instance" "t2-nano-inst" {
  ami = data.aws_ami.ubuntu.id
  instance_type = "t2.nano"
  vpc_security_group_ids = [data.aws_security_group.sg-web-api.id, data.aws_security_group.sg-ssh.id]
  key_name = aws_key_pair.pub-key.key_name
  subnet_id = data.aws_subnet.main-public-1.id

  tags = {
    Name = "aws-dev-cert-assoc-quarkus-camel-rest-ec2"
  }

}

resource "null_resource" "execute-native-api" {
  connection {
    agent = false
    type = "ssh"
    user = "ubuntu"
    host = aws_instance.t2-nano-inst.public_ip
    private_key = file("../../../.secret/key.pem")
  }

  # update and create app folder
  provisioner "remote-exec" {
    inline = [
      "sudo apt-get -y update",
      "mkdir /home/ubuntu/app"
    ]
  }

  # copy native file to app folder
  provisioner "file" {
    source = "./script/script.sh"
    destination = "/home/ubuntu/app/script.sh"
  }

  # copy native file to app folder
  provisioner "file" {
    source = "../../../mp-module03-ec2-quarkus-camel-rest/target/mp-module03-ec2-quarkus-camel-rest-1.0.0-SNAPSHOT-runner"
    destination = "/home/ubuntu/app/quarkus-camel-api"
  }

  # create execution permission to native file in app folder
  provisioner "remote-exec" {
    inline = [
      "cd /home/ubuntu/app",
      "sudo chmod u+x quarkus-camel-api",
      "sudo ./quarkus-camel-api &"
    ]
  }
  
  depends_on = [aws_instance.t2-nano-inst]
}

resource "aws_key_pair" "pub-key" {
  key_name = "key-pub"
  public_key = file("../../../.secret/key.pub")
}
