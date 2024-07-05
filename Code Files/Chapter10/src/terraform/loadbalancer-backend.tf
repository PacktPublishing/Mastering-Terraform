
resource "azurerm_lb" "backend" {
  name                = "lb-${var.application_name}-${var.environment_name}-backend"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  sku                 = "Standard"

  frontend_ip_configuration {
    name      = "PrivateIP"
    subnet_id = azurerm_subnet.backend.id
    zones     = [1, 2, 3]
  }
}
resource "azurerm_lb_backend_address_pool" "backend" {
  loadbalancer_id = azurerm_lb.backend.id
  name            = "backend-pool"
}

# Connects this Virtual Machine to the Load Balancer's Backend Address Pool
resource "azurerm_network_interface_backend_address_pool_association" "backend" {

  count = var.az_count

  network_interface_id    = azurerm_network_interface.backend[count.index].id
  ip_configuration_name   = "internal"
  backend_address_pool_id = azurerm_lb_backend_address_pool.backend.id

}

resource "azurerm_lb_probe" "backend_probe_http" {
  loadbalancer_id = azurerm_lb.backend.id
  name            = "http"
  protocol        = "Http"
  port            = 5000
  request_path    = "/health"
}

resource "azurerm_lb_rule" "backend_http" {
  loadbalancer_id                = azurerm_lb.backend.id
  name                           = "HTTP"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 5000
  frontend_ip_configuration_name = "PrivateIP"
  probe_id                       = azurerm_lb_probe.backend_probe_http.id
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.backend.id]
  disable_outbound_snat          = true
}