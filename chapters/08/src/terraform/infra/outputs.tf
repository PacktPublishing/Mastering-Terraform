output "frontend_repository" {
  value = aws_ecr_repository.main["frontend"].name
}
output "frontend_repository_url" {
  value = aws_ecr_repository.main["frontend"].repository_url
}
output "backend_repository" {
  value = aws_ecr_repository.main["backend"].name
}
output "backend_repository_url" {
  value = aws_ecr_repository.main["backend"].repository_url
}
output "kubernetes_cluster_name" {
  value = aws_eks_cluster.main.name
}
output "primary_region" {
  value = var.primary_region
}
output "console_role_arn" {
  value = aws_iam_role.console_access.arn
}
output "admin_group_arn" {
  value = aws_iam_group.admin.arn
}
output "alb_controller_role" {
  value = aws_iam_role.alb_controller.arn
}
output "workload_identity_role" {
  value = aws_iam_role.workload_identity.arn
}