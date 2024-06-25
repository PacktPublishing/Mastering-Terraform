
data "aws_iam_policy_document" "container_node_group" {

  statement {
    sid     = "EKSNodeAssumeRole"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "container_node_group" {
  name = "eks-${var.application_name}-${var.environment_name}-nodegroup-role"

  assume_role_policy = data.aws_iam_policy_document.container_node_group.json

  tags = {
    application = var.application_name
    environment = var.environment_name
  }
}

# EKS Worker Node
resource "aws_iam_role_policy_attachment" "eks_worker_node_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.container_node_group.name
}

# CNI
resource "aws_iam_role_policy_attachment" "eks_cni_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.container_node_group.name
}

# ECR
resource "aws_iam_role_policy_attachment" "eks_ecr_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.container_node_group.name
}

# CloudWatch
resource "aws_iam_role_policy_attachment" "cloudwatch" {
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
  role       = aws_iam_role.container_node_group.name
}

# ALB
resource "aws_iam_role_policy_attachment" "alb" {
  policy_arn = aws_iam_policy.alb_controller.arn
  role       = aws_iam_role.container_node_group.name
}