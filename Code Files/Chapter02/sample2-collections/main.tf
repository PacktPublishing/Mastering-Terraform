locals {
  network_list = [
    {
      name    = "westus"
      network = "10.0.0.0/16"
    },
    {
      name    = "eastus"
      network = "10.1.0.0/16"
    }
  ]
  network_map = {
    "westus" = "10.0.0.0/16"
    "eastus" = "10.1.0.0/16"
  }
}