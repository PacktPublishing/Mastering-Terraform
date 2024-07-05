resource "azurerm_resource_group" "foobar" {
  name     = "rg-foobar"
  location = "westus"
}

locals {
  regions = {
    westus = 0
    eastus = 1
  }
}

resource "azurerm_cosmosdb_account" "db" {

  name                = "cosmos-foobar"
  location            = azurerm_resource_group.foobar.location
  resource_group_name = azurerm_resource_group.foobar.name
  offer_type          = "Standard"
  kind                = "MongoDB"

  consistency_policy {
    consistency_level = "Strong"
  }

  dynamic "geo_location" {
    for_each = local.regions
    content {
      location          = geo_location.key
      failover_priority = geo_location.value
    }
  }

}
