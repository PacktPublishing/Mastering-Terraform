locals {
  dynamic_name = "foo-${random_string.random.result}"
}

resource "random_string" "random" {
  length  = 4
  upper   = false
  special = false
}