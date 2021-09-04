resource "aws_alb_listener" "alb-listener-http" {
  load_balancer_arn = aws_alb.alb_main.id
  port              = var.AWS_LB_PORT
  protocol          = var.AWS_LB_PROTOCOL

  default_action {
    target_group_arn = aws_alb_target_group.alb-tg-main.id
    type             = "forward"
    fixed_response {
      content_type = "application/json"
      status_code  = 200
    }
  }
}

