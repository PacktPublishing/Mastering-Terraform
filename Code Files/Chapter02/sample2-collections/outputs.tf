output "eastus_from_list" {
  value = local.network_list[1]
}
output "eastus_from_map" {
  value = local.network_map["eastus"]
}