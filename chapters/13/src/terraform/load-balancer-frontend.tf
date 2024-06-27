resource "google_compute_backend_service" "backend_service" {

  project     = google_project.main.project_id
  name        = "my-backend-service"
  port_name   = "http"
  protocol    = "HTTP"
  timeout_sec = 10

  dynamic "backend" {
    for_each = google_compute_instance_group.frontend
    content {
      group = backend.value.self_link
    }
  }

  health_checks = [google_compute_http_health_check.frontend.self_link]
}

resource "google_compute_url_map" "url_map" {
  project         = google_project.main.project_id
  name            = "my-url-map"
  default_service = google_compute_backend_service.backend_service.self_link
}

resource "google_compute_target_http_proxy" "http_proxy" {
  project = google_project.main.project_id
  name    = "my-http-proxy"
  url_map = google_compute_url_map.url_map.self_link
}

resource "google_compute_global_forwarding_rule" "frontend" {
  project     = google_project.main.project_id
  name        = "my-forwarding-rule"
  ip_protocol = "TCP"
  port_range  = "80"
  target      = google_compute_target_http_proxy.http_proxy.self_link
}

resource "google_compute_http_health_check" "frontend" {

  project      = google_project.main.project_id
  name         = "${var.application_name}-${var.environment_name}-hc"
  port         = 5000
  request_path = "/"
}

/*
resource "google_compute_forwarding_rule" "main" {
  name                  = "${var.application_name}-${var.environment_name}"
  target                = google_compute_target_pool.main.self_link
  load_balancing_scheme = "EXTERNAL"
  port_range            = 80
  region                = var.primary_region
  ip_protocol           = "TCP"
}

resource "google_compute_target_pool" "main" {
  name             = "${var.application_name}-${var.environment_name}"
  region           = var.primary_region
  session_affinity = "CLIENT_IP"
  instances        = google_compute_instance.frontend.*.self_link
  health_checks    = [google_compute_http_health_check.main.self_link]
}

resource "google_compute_http_health_check" "main" {
  name = "${var.application_name}-${var.environment_name}-hc"

  port         = 5000
  request_path = "/"
}
*/