resource "aws_security_group" "frontend_lb" {
  name        = "${var.application_name}-${var.environment_name}-frontend-lb-sg"
  description = "Security group for the load balancer"
  vpc_id      = aws_vpc.main.id
}

# allow traffic from the internet to flow into the ALB
resource "aws_security_group_rule" "frontend_lb_ingress_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = aws_security_group.frontend_lb.id
  cidr_blocks       = ["0.0.0.0/0"]
}

# allow traffic from the ALB to flow into the EC2 instances
resource "aws_security_group_rule" "frontend_lb_egress_http" {
  type                     = "egress"
  from_port                = 5000
  to_port                  = 5000
  protocol                 = "tcp"
  security_group_id        = aws_security_group.frontend_lb.id
  source_security_group_id = aws_security_group.frontend.id
}
