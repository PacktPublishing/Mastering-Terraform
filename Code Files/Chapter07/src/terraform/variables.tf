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
variable "frontend_instance_type" {
  type = string
}
variable "backend_image_name" {
  type = string
}
variable "backend_instance_type" {
  type = string
}
variable "domain_name" {
  type = string
}
variable "ssh_public_key" {
  type = string
}
variable "vpc_cidr_block" {
  type = string
}
variable "az_count" {
  type = number
}