
resource "aws_eks_node_group" "main" {
  cluster_name    = aws_eks_cluster.main.name
  node_group_name = "ng-user"
  node_role_arn   = aws_iam_role.container_node_group.arn
  subnet_ids      = local.cluster_subnet_ids

  scaling_config {
    desired_size = 3
    min_size     = 1
    max_size     = 4
  }

  update_config {
    max_unavailable = 1
  }

  ami_type       = var.node_image_type
  instance_types = [var.node_size]

  depends_on = [
    aws_iam_role_policy_attachment.eks_worker_node_policy,
    aws_iam_role_policy_attachment.eks_cni_policy,
    aws_iam_role_policy_attachment.eks_ecr_policy,
  ]
}
