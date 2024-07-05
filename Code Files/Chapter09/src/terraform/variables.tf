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