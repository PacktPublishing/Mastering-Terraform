data "aws_iam_policy_document" "lambda" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "lambda" {
  name               = "${var.application_name}-${var.environment_name}-lambda"
  assume_role_policy = data.aws_iam_policy_document.lambda.json
}

resource "aws_iam_policy" "lambda_logging" {
  name        = "${var.application_name}-${var.environment_name}-lambda-logging-policy"
  description = "Allow Lambda to log to CloudWatch"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Effect   = "Allow"
        Resource = "arn:aws:logs:*:*:*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_logging" {
  role       = aws_iam_role.lambda.name
  policy_arn = aws_iam_policy.lambda_logging.arn
}

resource "aws_lambda_function" "main" {
  function_name = "${var.application_name}-${var.environment_name}"
  role          = aws_iam_role.lambda.arn
  runtime       = "dotnet6"
  filename      = "deployment.zip"
  handler       = "FleetAPI::FleetAPI.Function::FunctionHandler"

  environment {
    variables = {
      SECRET_SAUCE = random_password.secret_sauce.result
    }
  }

  tags = {
    Name        = "${var.application_name}-${var.environment_name}-lambda"
    application = var.application_name
    environment = var.environment_name
  }
}
