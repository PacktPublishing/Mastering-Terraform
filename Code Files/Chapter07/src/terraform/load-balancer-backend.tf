
resource "aws_lb_target_group" "backend_http" {

  name                          = "${var.application_name}-${var.environment_name}-backend-http"
  port                          = 5000
  protocol                      = "HTTP"
  vpc_id                        = aws_vpc.main.id
  slow_start                    = 0
  load_balancing_algorithm_type = "round_robin"

  stickiness {
    enabled = true
    type    = "lb_cookie"
  }

  health_check {
    enabled             = true
    port                = 5000
    interval            = 30
    protocol            = "HTTP"
    path                = "/health"
    matcher             = 200
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }

}

resource "aws_lb_target_group_attachment" "backend_http" {

  for_each = aws_instance.backend

  target_group_arn = aws_lb_target_group.backend_http.arn
  target_id        = each.value.id
  port             = 5000

}

resource "aws_lb" "backend" {
  name               = "${var.application_name}-${var.environment_name}-backend"
  internal           = true
  load_balancer_type = "application"
  subnets            = [for subnet in values(aws_subnet.backend) : subnet.id]
  security_groups    = [aws_security_group.backend_lb.id]

  tags = {
    Name        = "${var.application_name}-${var.environment_name}-backend-lb"
    application = var.application_name
    environment = var.environment_name
  }
}

resource "aws_lb_listener" "backend_http" {

  load_balancer_arn = aws_lb.backend.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.backend_http.arn
  }
}
