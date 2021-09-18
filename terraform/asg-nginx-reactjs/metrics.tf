resource "aws_autoscaling_policy" "asp-main" {
  name                   = "asp-main"
  autoscaling_group_name = aws_autoscaling_group.nginx-asg.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = 42
  cooldown               = 300
  policy_type            = "SimpleScaling"
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm
resource "aws_cloudwatch_metric_alarm" "asma-main" {
  alarm_name          = "asma-main"
  alarm_description   = "CPU Metric over Cloudwatch"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 120
  statistic           = "Average"
  threshold           = 50
  dimensions = {
    "AutoScalinggroupName" = aws_autoscaling_group.nginx-asg.name
  }

  actions_enabled = true
  alarm_actions   = [aws_autoscaling_policy.asp-main.arn]
}
