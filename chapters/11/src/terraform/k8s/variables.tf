variable "registry_endpoint" {
  description = "The endpoint of the container registry"
  type        = string
}
variable "application_name" {
  type = string
}
variable "environment_name" {
  type = string
}
variable "namespace" {
  type = string
}
variable "service_account_name" {
  type = string
}
variable "service_account_client_id" {
  type = string
}
variable "web_app_image" {
  type = object({
    name    = string
    version = string
  })
}
variable "web_api_image" {
  type = object({
    name    = string
    version = string
  })
}
variable "keyvault_name" {
  type = string
}
variable "tenant_id" {
  type = string
}
variable "backend_endpoint" {
  type = string
}