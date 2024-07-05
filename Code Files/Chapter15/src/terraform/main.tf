data "google_billing_account" "main" {
  display_name    = "Default"
  lookup_projects = false
}

data "google_client_config" "current" {
}
data "google_client_openid_userinfo" "provider_identity" {
}

resource "google_project" "main" {
  name            = "${var.application_name}-${var.environment_name}"
  project_id      = "${var.application_name}-${var.environment_name}-${random_string.project_id.result}"
  org_id          = var.gcp_organization
  billing_account = data.google_billing_account.main.id
}

resource "random_string" "project_id" {
  length  = 8
  special = false
  upper   = false
}

resource "google_project_iam_member" "project_admins" {

  count =length(var.project_admins)

  project = google_project.main.project_id
  role    = "roles/owner"
  member  =  "user:${var.project_admins[count.index]}"

  depends_on = [ google_project_iam_member.terraform_user ]
}

resource "google_project_iam_member" "terraform_user" {
  project = google_project.main.project_id
  role    = "roles/owner"
  member  = "serviceAccount:${data.google_client_openid_userinfo.provider_identity.email}"
}

resource "google_project_iam_member" "terraform_user_storage" {
  project = google_project.main.project_id
  role    = "roles/storage.admin"
  member  = "serviceAccount:${data.google_client_openid_userinfo.provider_identity.email}"
}

resource "google_project_iam_member" "terraform_user_compute" {
  project = google_project.main.project_id
  role    = "roles/compute.admin"
  member  = "serviceAccount:${data.google_client_openid_userinfo.provider_identity.email}"
}