
resource "google_secret_manager_secret" "sauce" {
  secret_id = "sauce"

  replication {
    user_managed {
      replicas {
        location = var.primary_region
      }
    }
  }
}

resource "google_secret_manager_secret_version" "sauce" {
  secret = google_secret_manager_secret.sauce.name

  secret_data = "foo"
  enabled     = true
}