/*
resource "google_compute_global_address" "frontend" {
  name         = "lb-address"
  project      = google_project.main.project_id
  address_type = "EXTERNAL"
}

resource "google_compute_backend_service" "frontend" {
  name    = "backend-service"
  project = google_project.main.project_id
  backend {
    group = google_container_node_pool.primary.instance_group_urls[0]
  }
}

resource "google_compute_url_map" "frontend" {
  name            = "url-map"
  project         = google_project.main.project_id
  default_service = google_compute_backend_service.frontend.self_link
}

resource "google_compute_target_http_proxy" "frontend" {
  name    = "http-proxy"
  project = google_project.main.project_id
  url_map = google_compute_url_map.frontend.self_link
}

resource "google_compute_global_forwarding_rule" "frontend" {
  name                  = "forwarding-rule"
  project               = google_project.main.project_id
  load_balancing_scheme = "EXTERNAL"
  target                = google_compute_target_http_proxy.frontend.self_link
  port_range            = "80"
  ip_address            = google_compute_global_address.frontend.address
}*/