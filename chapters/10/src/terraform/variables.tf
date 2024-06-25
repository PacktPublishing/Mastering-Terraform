variable "application_name" {
  type = string
}
variable "environment_name" {
  type = string
}
variable "primary_region" {
  type = string
}
variable "domain_name" {
  type = string
}
variable "vnet_cidr_block" {
  type = string
}
variable "az_count" {
  type = number
}
variable "admin_username" {
  type = string
}
variable "frontend_image" {
  type = object({
    name                = string
    resource_group_name = string
  })
}
variable "frontend_instance_type" {
  type = string
}
variable "backend_image" {
  type = object({
    name                = string
    resource_group_name = string
  })
}
variable "backend_instance_type" {
  type = string
}