resource "aws_secretsmanager_secret" "secret_sauce" {
  name = "secret-sauce"

  tags = {
    application = var.application_name
    environment = var.environment_name
  }
}

resource "aws_secretsmanager_secret_version" "secret_sauce" {
  secret_id     = aws_secretsmanager_secret.secret_sauce.id
  secret_string = random_password.secret_sauce.result
}

resource "random_password" "secret_sauce" {
  length  = 8
  lower   = false
  special = false
}

resource "aws_iam_policy" "lambda_secrets" {
  name        = "${var.application_name}-${var.environment_name}-secrets-policy"
  description = "Policy to allow Lambda function to access secrets."

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = ["secretsmanager:GetSecretValue"],
        Effect = "Allow",
        Resource = [
          aws_secretsmanager_secret.secret_sauce.arn
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_secrets" {
  role       = aws_iam_role.lambda.name
  policy_arn = aws_iam_policy.lambda_secrets_policy.arn
}