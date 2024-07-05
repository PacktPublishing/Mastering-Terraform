/*
resource "google_compute_firewall" "allow_ssh" {
  name    = "allow-ssh"
  network = google_compute_network.main.self_link

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"] # Be cautious: This allows SSH from any IP. Adjust as necessary.
  target_tags   = ["ssh-access"]
}
*/
/*
resource "google_compute_firewall" "default-lb-fw" {

  name    = "${var.application_name}-${var.environment_name}-vm-service"
  network = google_compute_network.main.self_link

  allow {
    protocol = "tcp"
    ports    = [80]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["allow-lb-service"]
}*/

resource "google_compute_firewall" "default-hc-fw" {

  project = google_project.main.project_id
  name    = "${var.application_name}-${var.environment_name}-hc"
  network = google_compute_network.main.self_link

  allow {
    protocol = "tcp"
    ports    = [5000]
  }

  source_ranges = ["130.211.0.0/22", "35.191.0.0/16"]
  target_tags   = ["allow-lb-service"]
}