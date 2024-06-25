variable "application_name" {
  type = string
}
variable "environment_name" {
  type = string
}
variable "primary_region" {
  type = string
}
variable "ecr_image_pushers" {
  type = list(string)
}
variable "vpc_cidr_block" {
  type = string
}
variable "az_count" {
  type = number
}
variable "node_image_type" {
  type = string
}
variable "node_size" {
  type = string
}
variable "admin_users" {
  type = list(string)
}
variable "k8s_namespace" {
  type = string
}
variable "k8s_service_account_name" {
  type = string
}