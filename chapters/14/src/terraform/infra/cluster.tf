resource "google_container_cluster" "main" {
  project  = google_project.main.project_id
  name     = "gke-${var.application_name}-${var.environment_name}-${random_string.project_id.result}"
  location = var.primary_region
  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1
  deletion_protection      = false

  network    = google_compute_network.main.self_link
  subnetwork = google_compute_subnetwork.backend.self_link

  workload_identity_config {
    workload_pool = "${google_project.main.project_id}.svc.id.goog"
  }

}

resource "google_container_node_pool" "primary" {

  project    = google_project.main.project_id
  name       = "gke-${var.application_name}-${var.environment_name}-${random_string.project_id.result}-primary"
  location   = var.primary_region
  cluster    = google_container_cluster.main.name
  node_count = var.node_count

  node_config {

    preemptible  = false
    spot         = false
    machine_type = var.node_size

    workload_metadata_config {
      mode = "GKE_METADATA"
    }

    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = google_service_account.cluster.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring"
    ]

  }
}