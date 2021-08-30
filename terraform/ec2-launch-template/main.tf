terraform {
  required_version = "~> 1.0.3"
}

resource "aws_launch_template" "my-http-ec2-inst-template" {

  name = "My HttpD WebServer"
  default_version = "v1"

  block_device_mappings {
    device_name = "/dev/sda1"
    ebs {
      volume_size = 2
      # GiB
    }
  }

  capacity_reservation_specification {
    capacity_reservation_preference = "open"
  }

  cpu_options {
    core_count = 4
    threads_per_core = 2
  }

  credit_specification {
    cpu_credits = "standard"
  }

  disable_api_termination = true

  ebs_optimized = true

  image_id = "amzn2-ami-hvm-2.0.20200406-x86_640-gp2"
  instance_initiated_shutdown_behavior = "terminate"

  instance_market_options {
    market_type = "spot"
  }

  instance_type = "t2.micro"

  key_name = aws_key_pair.pub-key.key_name


  monitoring {
    enabled = true
  }

  network_interfaces {
    associate_public_ip_address = true
  }

  placement {
    availability_zone = "sa-east-2a"
  }

  ram_disk_id = "test"

  vpc_security_group_ids = ["sg-12345678"] # SG inbound 80 port

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "test"
    }
  }

  user_data = filebase64("./httpd.sh")

}

resource "aws_key_pair" "pub-key" {
  key_name = "key-pub"
  public_key = file("../../.secret/key.pub")
}