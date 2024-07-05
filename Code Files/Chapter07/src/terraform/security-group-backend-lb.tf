resource "aws_security_group" "backend_lb" {
  name        = "${var.application_name}-${var.environment_name}-backend-lb-sg"
  description = "Security group for the load balancer"
  vpc_id      = aws_vpc.main.id
}

# allow traffic from the frontend ec2 to flow into the ALB
resource "aws_security_group_rule" "backend_lb_ingress_http" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = aws_security_group.backend_lb.id
  source_security_group_id = aws_security_group.frontend.id
}

# allow traffic from the backend ALB to flow into the EC2 instances
resource "aws_security_group_rule" "backend_lb_egress_http" {
  type                     = "egress"
  from_port                = 5000
  to_port                  = 5000
  protocol                 = "tcp"
  security_group_id        = aws_security_group.backend_lb.id
  source_security_group_id = aws_security_group.backend.id
}
