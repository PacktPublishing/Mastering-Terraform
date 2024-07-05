output "project_id" {
  value = google_project.main.project_id
}
output "current_user" {
  value = data.google_client_openid_userinfo.provider_identity.email
}
output "kubernetes_cluster_name" {
  value = google_container_cluster.main.name
}
output "primary_region" {
  value = var.primary_region
}
output "container_registry_endpoint" {
  value = "${var.primary_region}-docker.pkg.dev"
}
output "frontend_registry" {
  value = google_artifact_registry_repository.frontend.name
}
output "backend_registry" {
  value = google_artifact_registry_repository.backend.name
}