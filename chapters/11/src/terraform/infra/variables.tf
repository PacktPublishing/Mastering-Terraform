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
variable "aks_orchestration_version" {
  type = string
}
variable "aks_system_pool" {
  type = object({
    vm_size        = string
    min_node_count = number
    max_node_count = number
  })
}
variable "aks_workload_pool" {
  type = object({
    vm_size        = string
    min_node_count = number
    max_node_count = number
  })
}
variable "container_registry_pushers" {
  type = list(string)
}
variable "keyvault_readers" {
  type = list(string)
}
variable "keyvault_admins" {
  type = list(string)
}
variable "k8s_namespace" {
  type = string
}
variable "k8s_service_account_name" {
  type = string
}
variable "database_admin_username" {
  type = string
}