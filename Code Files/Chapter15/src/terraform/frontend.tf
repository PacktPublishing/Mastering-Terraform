
resource "google_storage_bucket" "frontend" {

  project  = google_project.main.project_id
  name     = "${var.application_name}-${var.environment_name}-frontend-${random_string.project_id.result}"
  location = "US"

  website {
    main_page_suffix = "index.html"
    not_found_page   = "404.html"
  }

  cors {
    origin          = ["*"]
    method          = ["GET", "HEAD"]
    response_header = ["Authorization", "Content-Type"]
    max_age_seconds = 3600
  }

  depends_on = [google_project_iam_member.terraform_user_storage]
}

resource "google_storage_bucket_iam_binding" "frontend" {
  bucket = google_storage_bucket.frontend.name
  role   = "roles/storage.objectViewer"

  members = [
    "allUsers"
  ]
}
