application_name = "fleet-ops"
environment_name = "dev"
k8s_namespace    = "app"
web_app_image = {
  name    = "frontend/frontend"
  version = "2024.06.21"
}
web_api_image = {
  name    = "backend/backend"
  version = "2024.06.13"
}