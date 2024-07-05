resource "google_artifact_registry_repository" "frontend" {
  project       = google_project.main.project_id
  location      = var.primary_region
  repository_id = "frontend"
  format        = "DOCKER"
}

resource "google_artifact_registry_repository" "backend" {
  project       = google_project.main.project_id
  location      = var.primary_region
  repository_id = "backend"
  format        = "DOCKER"
}