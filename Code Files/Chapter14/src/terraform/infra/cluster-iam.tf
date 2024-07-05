locals {
  cluster_roles = [
    "roles/artifactregistry.reader"
  ]
  cluster_admin_roles = [
    "roles/container.clusterAdmin",
    "roles/container.developer",
    "roles/container.viewer",
    "roles/artifactregistry.writer",
    "roles/artifactregistry.reader"
  ]
}

resource "google_service_account" "cluster" {
  project      = google_project.main.project_id
  account_id   = "sa-gke-${var.application_name}-${var.environment_name}-${random_string.project_id.result}"
  display_name = "sa-gke-${var.application_name}-${var.environment_name}-${random_string.project_id.result}"
}

resource "google_project_iam_binding" "cluster" {

  count = length(local.cluster_roles)

  project = google_project.main.project_id
  role    = local.cluster_roles[0]

  members = [
    "serviceAccount:${google_service_account.cluster.email}"
  ]
}

resource "google_project_iam_member" "terraform_cluster_admin" {

  count = length(local.cluster_admin_roles)

  project = google_project.main.project_id
  member  = "serviceAccount:${data.google_client_openid_userinfo.provider_identity.email}"
  role    = local.cluster_admin_roles[count.index]

}