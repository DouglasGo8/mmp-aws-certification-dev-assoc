terraform {
  required_version = "~> 1.0.3"
}

resource "aws_launch_template" "httpd-launch-template" {
  name                                 = "httpd_template"
  name_prefix                          = "httpd_template"
  ebs_optimized                        = true
  disable_api_termination              = true
  image_id                             = data.aws_ami.amzn2.id
  instance_type                        = var.AMZ_INSTANCE_TYPE
  user_data                            = filebase64("./httpd.sh")
  key_name                             = aws_key_pair.key-pub.key_name
  vpc_security_group_ids               = [data.aws_security_group.allow-ssh-http.id]
  instance_initiated_shutdown_behavior = "terminate"

  instance_market_options {
    market_type = "spot"
  }

  capacity_reservation_specification {
    capacity_reservation_preference = "open"
  }

  monitoring {
    enabled = false
  }

  cpu_options {
    core_count       = 4
    threads_per_core = 2
  }

  credit_specification {
    cpu_credits = "standard"
  }

  lifecycle {
    create_before_destroy = true
  }

}

resource "aws_autoscaling_group" "httpd-asg" {
  name             = "httpd-asg"
  min_size         = 1
  max_size         = 2
  desired_capacity = 1
  force_delete     = true
  vpc_zone_identifier = [
    "${data.aws_subnet.main-public-1.id}",
    "${data.aws_subnet.main-public-2.id}",
    "${data.aws_subnet.main-public-3.id}"
  ]
  target_group_arns         = ["value"]
  health_check_grace_period = 300
  health_check_type         = "ELB"
  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupTotalInstances"
  ]
  launch_template {
    id      = aws_launch_template.httpd-launch-template.id
    version = "$Latest"
  }
  tag {
    key                 = "ASGHttpD"
    value               = "EC2 Micro Instance"
    propagate_at_launch = true
  }
}


resource "aws_key_pair" "key-pub" {
  key_name   = "key-pub"
  public_key = file("../.secret/key.pub")
}
