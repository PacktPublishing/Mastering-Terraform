output "project_id" {
  value = google_project.main.project_id
}
output "frontend_bucket_name" {
  value = google_storage_bucket.frontend.name
}
/*
output "current_user" {
  value = data.google_client_openid_userinfo.provider_identity.email
}
output "host" {
  value     = google_container_cluster.main.endpoint
  sensitive = true
}
output "client_certificate" {
  value     = google_container_cluster.main.master_auth.0.client_certificate
  sensitive = true
}
output "client_key" {
  value     = google_container_cluster.main.master_auth.0.client_key
  sensitive = true
}
output "cluster_ca_certificate" {
  value     = google_container_cluster.main.master_auth.0.cluster_ca_certificate
  sensitive = true
}*/