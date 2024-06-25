resource "aws_iam_role" "backend" {
  name = "${var.application_name}-${var.environment_name}-backend"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    Name        = "${var.application_name}-${var.environment_name}-backend-role"
    application = var.application_name
    environment = var.environment_name
  }
}

resource "aws_iam_role_policy" "backend" {
  name = "${var.application_name}-${var.environment_name}-backend"
  role = aws_iam_role.backend.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "secretsmanager:GetSecretValue",
        ]
        Effect   = "Allow"
        Resource = "arn:aws:secretsmanager:secret:${var.application_name}/${var.environment_name}/*"
      },
    ]
  })
}