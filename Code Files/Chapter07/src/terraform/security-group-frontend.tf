resource "aws_security_group" "frontend" {
  name        = "${var.application_name}-${var.environment_name}-frontend-sg"
  description = "Security group for the frontend EC2 instances"
  vpc_id      = aws_vpc.main.id
}

# Allow traffic from the Frontend ALB into the Frontend EC2 Instances
resource "aws_security_group_rule" "frontend_http" {
  type                     = "ingress"
  from_port                = 5000
  to_port                  = 5000
  protocol                 = "tcp"
  security_group_id        = aws_security_group.frontend.id
  source_security_group_id = aws_security_group.frontend_lb.id
}

# Allow SSH Access to Frontend EC2 Instances
resource "aws_security_group_rule" "frontend_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.frontend.id
  cidr_blocks       = ["0.0.0.0/0"]
}

# allow traffic from the Frontend to flow into the Backend Load Balancer
resource "aws_security_group_rule" "frontend_egress_http" {
  type                     = "egress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = aws_security_group.frontend.id
  source_security_group_id = aws_security_group.backend_lb.id
}
