locals {
  cidr_block_list     = range(0, 4)
  dynamic_cidr_blocks = [for i in local.cidr_block_list : cidrsubnet("10.0.0.0/16", 16, i)]
}