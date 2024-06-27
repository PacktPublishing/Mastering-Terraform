variable "application_name" {
  type = string
}
variable "environment_name" {
  type = string
}
variable "primary_region" {
  type = string
}
variable "gcp_organization" {
  type = string
}
variable "project_admins" {
  type = list(string)
}