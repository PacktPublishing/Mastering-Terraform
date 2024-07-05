locals {
  cluster_name       = "eks-${var.application_name}-${var.environment_name}"
  cluster_subnet_ids = [for subnet in values(aws_subnet.backend) : subnet.id]
}

resource "aws_eks_cluster" "main" {
  name                      = local.cluster_name
  role_arn                  = aws_iam_role.container_cluster.arn
  enabled_cluster_log_types = ["api", "audit"]

  vpc_config {

    security_group_ids = [
      aws_security_group.cluster.id,
      aws_security_group.cluster_nodes.id
    ]

    subnet_ids              = local.cluster_subnet_ids
    endpoint_public_access  = true
    endpoint_private_access = true
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_policy,
    aws_iam_role_policy_attachment.eks_vpc_controller_policy,
    aws_cloudwatch_log_group.container_cluster,
    aws_ecr_repository.main.*
  ]

  tags = {
    application = var.application_name
    environment = var.environment_name
  }
}
