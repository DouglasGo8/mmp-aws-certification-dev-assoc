terraform {
  required_version = "~> 1.0.3"
}

resource "aws_launch_template" "httpd-launch-template" {
  name_prefix                          = "httpd-launch-template"
  image_id                             = data.aws_ami.amzn2.id
  instance_type                        = var.AMZ_INSTANCE_TYPE
  user_data                            = filebase64("./httpd.sh")
  key_name                             = aws_key_pair.key-pub.key_name
  vpc_security_group_ids               = [aws_security_group.sg-allow-http.id]
  instance_initiated_shutdown_behavior = "terminate"

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
    data.aws_subnet.main-public-1.id,
    data.aws_subnet.main-public-2.id,
    data.aws_subnet.main-public-3.id
  ]
  target_group_arns         = [aws_lb_target_group.alb-tg-httpd.arn]
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
    key                 = "Name"
    value               = "EC2 Micro Instance"
    propagate_at_launch = true
  }
}

resource "aws_key_pair" "key-pub" {
  key_name   = "key-pub"
  public_key = file("../.secret/key.pub")
}
