# https://docs.aws.amazon.com/eks/latest/userguide/connector_IAM_role.html

data "aws_iam_policy_document" "eks_connector_assume_role_policy" {
  version = "2012-10-17"
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["ssm.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "eks_connector" {
  name               = "AmazonEKSConnectorAgentRole"
  assume_role_policy = data.aws_iam_policy_document.eks_connector_assume_role_policy.json
}

data "aws_iam_policy_document" "eks_connector" {
  version = "2012-10-17"
  statement {
    sid       = "SsmControlChannel"
    effect    = "Allow"
    actions   = ["ssmmessages:CreateControlChannel"]
    resources = ["arn:aws:eks:*:*:cluster/*"]
  }

  statement {
    sid    = "ssmDataplaneOperations"
    effect = "Allow"
    actions = [
      "ssmmessages:CreateDataChannel",
      "ssmmessages:OpenDataChannel",
      "ssmmessages:OpenControlChannel"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "eks_connector" {
  name   = "AmazonEKSConnectorAgentPolicy"
  policy = data.aws_iam_policy_document.eks_connector.json
}

resource "aws_iam_role_policy_attachment" "eks_connector" {
  role       = aws_iam_role.eks_connector.name
  policy_arn = aws_iam_policy.eks_connector.arn
}
