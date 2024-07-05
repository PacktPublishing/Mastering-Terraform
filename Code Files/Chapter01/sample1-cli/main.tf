locals {
  dynamic_name = "${var.environment_name}-${random_string.random.result}"
}

resource "random_string" "random" {
  length  = 4
  upper   = false
  special = false
}