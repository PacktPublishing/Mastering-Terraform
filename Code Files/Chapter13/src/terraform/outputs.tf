output "selected_zones" {
  value = random_shuffle.az.result
}
output "zone_instances" {
  value = local.zone_instances
}