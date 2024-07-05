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