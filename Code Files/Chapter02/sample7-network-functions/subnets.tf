locals {
  split16_by      = 8
  split16_into_24 = [for x in range(256) : cidrsubnet("10.0.0.0/16", local.split16_by, x)]
}

locals {
  split_into_24 = cidrsubnets("10.0.0.0/16", 8, 8, 8, 8)
  split_subnets = cidrsubnets("10.0.4.0/23", 1, 1)
}