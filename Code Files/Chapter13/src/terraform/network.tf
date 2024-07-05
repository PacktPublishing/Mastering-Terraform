resource "google_compute_network" "main" {
  name                    = "${var.application_name}-${var.environment_name}"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "frontend" {

  project       = google_project.main.project_id
  name          = "frontend"
  region        = var.primary_region
  network       = google_compute_network.main.self_link
  ip_cidr_range = cidrsubnet(var.network_cidr_block, 2, 1)

}
resource "google_compute_subnetwork" "backend" {

  project       = google_project.main.project_id
  name          = "backend"
  region        = var.primary_region
  network       = google_compute_network.main.self_link
  ip_cidr_range = cidrsubnet(var.network_cidr_block, 2, 2)

}
