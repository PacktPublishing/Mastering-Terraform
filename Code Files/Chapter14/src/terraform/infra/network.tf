resource "google_compute_network" "main" {
  project                 = google_project.main.project_id
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

resource "google_compute_firewall" "allow_internet" {

  project = google_project.main.project_id
  name    = "allow-internet"
  network = google_compute_network.main.self_link

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  allow {
    protocol = "icmp"
  }

  direction          = "EGRESS"
  description        = "Allow internet access"
  destination_ranges = ["0.0.0.0/0"]
  source_ranges      = [google_compute_subnetwork.backend.ip_cidr_range]

  priority = 1000
}