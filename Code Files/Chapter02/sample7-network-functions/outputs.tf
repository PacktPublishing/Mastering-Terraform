output "cidrhost" {
  value = cidrhost("10.0.0.0/16", 128)
}
output "cidrnetmask" {
  value = cidrnetmask("10.0.0.0/16")
}
output "cidr_subnets" {
  value = local.split_subnets
}
output "cidr2" {
  value = local.dynamic_cidr_blocks
}