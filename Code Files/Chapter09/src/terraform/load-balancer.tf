locals {
  subnet_ids = [for subnet in values(aws_subnet.backend) : subnet.id]
}

resource "aws_security_group" "alb" {
  name        = "alb-${var.application_name}-${var.environment_name}"
  description = "Security group for ALB"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    application = var.application_name
    environment = var.environment_name
  }
}

resource "aws_lb" "main" {
  name               = "alb-${var.application_name}-${var.environment_name}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = local.subnet_ids

  enable_deletion_protection = false

  tags = {
    Name        = "${var.application_name}-${var.environment_name}-load-balancer"
    application = var.application_name
    environment = var.environment_name
  }
}

resource "aws_lb_target_group" "main" {
  name     = "alb-${var.application_name}-${var.environment_name}"
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id

  target_type = "lambda"

  health_check {
    enabled  = false
    interval = 60
    timeout  = 30
  }
}

resource "aws_lambda_permission" "alb" {
  statement_id  = "AllowALBInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.main.arn
  principal     = "elasticloadbalancing.amazonaws.com"
  source_arn    = aws_lb_target_group.main.arn
}

resource "aws_lb_target_group_attachment" "lambda" {
  target_group_arn = aws_lb_target_group.main.arn
  target_id        = aws_lambda_function.main.arn
  depends_on       = [aws_lambda_permission.alb]
}

resource "aws_lb_listener" "lambda" {
  load_balancer_arn = aws_lb.main.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }
}

resource "aws_lb_listener_rule" "backend" {
  listener_arn = aws_lb_listener.lambda.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }

  condition {
    path_pattern {
      values = ["/api/*"]
    }
  }

}