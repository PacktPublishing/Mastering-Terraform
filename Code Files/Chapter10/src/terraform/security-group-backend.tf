resource "azurerm_application_security_group" "backend" {

  name                = "asg-${var.application_name}-${var.environment_name}-backend"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

}

resource "azurerm_network_security_group" "backend" {

  name                = "nsg-${var.application_name}-${var.environment_name}-backend"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

}

resource "azurerm_network_security_rule" "backend_http" {

  resource_group_name                        = azurerm_resource_group.main.name
  network_security_group_name                = azurerm_network_security_group.backend.name
  name                                       = "allow-http"
  priority                                   = "2001"
  access                                     = "Allow"
  direction                                  = "Inbound"
  protocol                                   = "Tcp"
  source_port_range                          = "*"
  destination_port_range                     = "5000"
  source_application_security_group_ids      = [azurerm_application_security_group.frontend.id]
  destination_application_security_group_ids = [azurerm_application_security_group.backend.id]

}
