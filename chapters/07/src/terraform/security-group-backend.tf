resource "aws_security_group" "backend" {
  name        = "${var.application_name}-${var.environment_name}-backend-sg"
  description = "Security group for the backend EC2 instances"
  vpc_id      = aws_vpc.main.id
}

# Allow traffic from the Backend ALB into the Backend EC2 Instances
resource "aws_security_group_rule" "backend_http" {
  type                     = "ingress"
  from_port                = 5000
  to_port                  = 5000
  protocol                 = "tcp"
  security_group_id        = aws_security_group.backend.id
  source_security_group_id = aws_security_group.backend_lb.id
}

# Allow SSH Access to Backend EC2 Instances
resource "aws_security_group_rule" "backend_ssh" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = aws_security_group.backend.id
  source_security_group_id = aws_security_group.frontend.id
}