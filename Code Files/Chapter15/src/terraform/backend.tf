
resource "google_storage_bucket" "backend" {

  project  = google_project.main.project_id
  name     = "${var.application_name}-${var.environment_name}-backend-${random_string.project_id.result}"
  location = "US"

  depends_on = [google_project_iam_member.terraform_user_storage]
}

locals {
  timestamp = timestamp()
}

resource "random_string" "deployment" {
  keepers = {
    date = "${timestamp()}"
  }

  length  = 8
  special = false
  upper   = false

}

resource "google_storage_bucket_object" "deployment" {
  name   = "deployment.zip"
  bucket = google_storage_bucket.backend.name
  source = "deployment.zip"

  lifecycle {
    replace_triggered_by = [random_string.deployment]
  }
}

resource "google_cloudfunctions2_function" "backend" {

  project = google_project.main.project_id

  name        = "func-${var.application_name}-${var.environment_name}-backend-${random_string.project_id.result}"
  location    = var.primary_region
  description = "a new function"

  build_config {
    runtime     = "dotnet6"
    entry_point = "FleetAPI.Function"

    source {
      storage_source {
        bucket = google_storage_bucket.backend.name
        object = google_storage_bucket_object.deployment.name
      }
    }
  }

  service_config {
    max_instance_count = 1
    available_memory   = "256M"
    timeout_seconds    = 60
  }

  depends_on = [google_project_service.run]
}