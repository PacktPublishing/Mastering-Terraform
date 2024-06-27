variable "gcp_organization" {
  type = string
}
variable "application_name" {
  type = string
}
variable "environment_name" {
  type = string
}
variable "primary_region" {
  type = string
}
variable "frontend_image_name" {
  type = string
}
variable "frontend_machine_type" {
  type = string
}
variable "frontend_instance_count" {
  type = number
}
variable "backend_image_name" {
  type = string
}
variable "backend_instance_type" {
  type = string
}
variable "backend_instance_count" {
  type = number
}
variable "domain_name" {
  type = string
}
variable "network_cidr_block" {
  type = string
}
variable "az_count" {
  type = number
}