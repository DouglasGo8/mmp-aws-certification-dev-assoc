#
# Critical Metrics to corret autoscale instances
#
resource "aws_cloudwatch_metric_alarm" "cpu_utilization_high" {
  alarm_name          = "${var.AWS_PROJECT_NAME}-${var.AWS_ENVIRONMENT}-CPU-Utilization-High-${var.AWS_ECS_CPU_LOW_THRESHOLD_PER}"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = "60"
  statistic           = "Average"
  threshold           = var.AWS_ECS_CPU_LOW_THRESHOLD_PER

  dimensions = {
    ClusterName = aws_ecs_cluster.main-cluster.name
    ServiceName = aws_ecs_cluster.main-cluster.name
  }


  alarm_actions = [aws_appautoscaling_policy.app_up.arn]

}

resource "aws_cloudwatch_metric_alarm" "cpu_utilization_low" {
  alarm_name          = "${var.AWS_PROJECT_NAME}-${var.AWS_ENVIRONMENT}-CPU-Utilization-Low-${var.AWS_ECS_CPU_LOW_THRESHOLD_PER}"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = "60"
  statistic           = "Average"
  threshold           = var.AWS_ECS_CPU_LOW_THRESHOLD_PER

  dimensions = {
    ClusterName = aws_ecs_cluster.main-cluster.name
    ServiceName = aws_ecs_cluster.main-cluster.name
  }

  alarm_actions = [aws_appautoscaling_policy.app_down.arn]
}


resource "aws_appautoscaling_policy" "app_up" {
  name               = "app-scale-up"
  service_namespace  = aws_appautoscaling_target.app_scale_target.service_namespace
  resource_id        = aws_appautoscaling_target.app_scale_target.resource_id
  scalable_dimension = aws_appautoscaling_target.app_scale_target.scalable_dimension
  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 60
    metric_aggregation_type = "Average"
    step_adjustment {
      metric_interval_lower_bound = 0
      scaling_adjustment          = 1
    }
  }
}


resource "aws_appautoscaling_policy" "app_down" {
  name               = "app-scale-down"
  service_namespace  = aws_appautoscaling_target.app_scale_target.service_namespace
  resource_id        = aws_appautoscaling_target.app_scale_target.resource_id
  scalable_dimension = aws_appautoscaling_target.app_scale_target.scalable_dimension

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 300
    metric_aggregation_type = "Average"

    step_adjustment {
      metric_interval_upper_bound = 0
      scaling_adjustment          = -1
    }
  }
}
