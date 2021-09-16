terraform {
  required_version = "~> 1.0.3"
}


resource "aws_launch_template" "nginx-launch-template" {
  name_prefix                          = "nginx-launch-template"
  image_id                             = data.aws_ami.ubuntu.id
  instance_type                        = var.AMZ_INSTANCE_TYPE
  key_name                             = aws_key_pair.key-pub.key_name
  user_data                            = filebase64("./reactjsapp.sh")
  vpc_security_group_ids               = [aws_security_group.sg-allow-http.id]
  instance_initiated_shutdown_behavior = "terminate"

  lifecycle {
    create_before_destroy = true
  }

  iam_instance_profile {
    name = aws_iam_instance_profile.ec2_ecr_iam_inst_profile.name
    #arn = aws_iam_role.ec2-ecr-role.arn
  }
}

resource "aws_iam_instance_profile" "ec2_ecr_iam_inst_profile" {
  name = "ec2-iam-ecr-role"
  role = aws_iam_role.ec2-ecr-role.name
}

resource "aws_autoscaling_group" "nginx-asg" {
  name             = "nginx-asg"
  min_size         = 2
  max_size         = 3
  desired_capacity = 2
  force_delete     = true

  vpc_zone_identifier = [
    data.aws_subnet.main-public-1.id,
    data.aws_subnet.main-public-2.id,
    data.aws_subnet.main-public-3.id
  ]
  target_group_arns         = [aws_lb_target_group.alb-tg-nginx.arn]
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
    id      = aws_launch_template.nginx-launch-template.id
    version = "$Latest"
  }
  tag {
    key                 = "Name"
    value               = "EC2 Micro Instance"
    propagate_at_launch = true
  }

}

resource "aws_iam_role" "ec2-ecr-role" {
  name               = "ec2-ecr-access"
  assume_role_policy = file("./policies/ecr-role.json")
}

resource "aws_iam_policy" "ec2-ecr-role-policy" {
  name   = "ec2-ecr-policy"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ecr:GetAuthorizationToken",
        "ecr:BatchCheckLayerAvailability",
        "ecr:GetDownloadUrlForLayer",
        "ecr:BatchGetImage"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "ec2-ecr-policy-attach" {
  role       = aws_iam_role.ec2-ecr-role.name
  policy_arn = aws_iam_policy.ec2-ecr-role-policy.arn
  #policy = aws_iam_policy.ec2-ecr-role-policy.arn
}

resource "aws_key_pair" "key-pub" {
  key_name   = "key-pub"
  public_key = file("../.secret/key.pub")
}
