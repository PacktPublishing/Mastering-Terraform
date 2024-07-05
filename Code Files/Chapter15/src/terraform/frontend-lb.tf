
resource "google_compute_backend_bucket" "frontend" {

  project = google_project.main.project_id

  name        = "${var.application_name}-${var.environment_name}-frontend-${random_string.project_id.result}"
  bucket_name = google_storage_bucket.frontend.name
  enable_cdn  = true

  depends_on = [
    google_project_service.compute,
    google_project_iam_member.terraform_user_compute
  ]
}

resource "google_compute_url_map" "frontend" {

  project = google_project.main.project_id

  name            = "${var.application_name}-${var.environment_name}-frontend-${random_string.project_id.result}"
  default_service = google_compute_backend_bucket.frontend.self_link
}

resource "google_compute_target_http_proxy" "frontend" {

  project = google_project.main.project_id

  name    = "${var.application_name}-${var.environment_name}-frontend-${random_string.project_id.result}"
  url_map = google_compute_url_map.frontend.self_link
}

resource "google_compute_global_forwarding_rule" "frontend" {

  project = google_project.main.project_id

  name       = "${var.application_name}-${var.environment_name}-frontend-${random_string.project_id.result}"
  target     = google_compute_target_http_proxy.frontend.self_link
  port_range = "80"
}
