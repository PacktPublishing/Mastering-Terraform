
resource "google_service_account" "main" {
  project      = google_project.main.project_id
  account_id   = "${var.application_name}-${var.environment_name}-sa"
  display_name = "Custom SA for VM Instance"
}

data "google_compute_image" "frontend" {
  name = var.frontend_image_name
}

resource "google_compute_instance_group" "frontend" {

  count = var.az_count

  project   = google_project.main.project_id
  name      = "frontend-${count.index}"
  zone      = local.azs_random[count.index]
  instances = local.zone_instances[local.azs_random[count.index]].instances

  named_port {
    name = "http"
    port = 5000
  }
}

locals {
  zone_instances = { for z in local.azs_random : z =>
    {
      instances = flatten([
        for i in google_compute_instance.frontend :
        i.zone == z ? [i.self_link] : []
      ])
    }
  }
}

resource "google_compute_instance" "frontend" {

  count = var.frontend_instance_count

  project      = google_project.main.project_id
  name         = "vm${var.application_name}-${var.environment_name}-frontend-${count.index}"
  machine_type = var.frontend_machine_type
  zone         = local.azs_random[count.index % 2]

  boot_disk {
    initialize_params {
      image = data.google_compute_image.frontend.self_link
    }
  }

  // Local SSD disk
  scratch_disk {
    interface = "NVME"
  }

  network_interface {
    subnetwork = google_compute_subnetwork.frontend.self_link

    access_config {
      // Ephemeral public IP
    }
  }

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.main.email
    scopes = ["cloud-platform"]
  }

  tags = ["ssh-access", "allow-lb-service"]

}