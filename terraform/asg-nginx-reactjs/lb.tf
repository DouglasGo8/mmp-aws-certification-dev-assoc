
resource "aws_lb" "alb-nginx" {
  name               = "alb-nginx"
  internal           = false
  load_balancer_type = "application"
  subnets            = var.AMZ_SUBNETS
  security_groups    = [aws_security_group.sg-allow-lb-http.id]

  tags = {
    Name = "alb-nginx"
  }

}

resource "aws_lb_listener" "alb-listener-nginx" {
  load_balancer_arn = aws_lb.alb-nginx.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb-tg-nginx.arn
  }
}

resource "aws_lb_target_group" "alb-tg-nginx" {
  name        = "alb-tg-nginx"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = var.VPC_ID

  health_check {
    port                = 80
    interval            = 10
    path                = "/"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 5
  }
}
