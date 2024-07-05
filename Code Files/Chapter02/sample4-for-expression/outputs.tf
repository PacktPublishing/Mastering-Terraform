output "original_input" {
  value = var.regions
}
output "region_list" {
  value = local.region_names_list
}
output "region_map" {
  value = local.region_config_object
}
output "region_array_from_map" {
  value = local.region_array_from_map
}