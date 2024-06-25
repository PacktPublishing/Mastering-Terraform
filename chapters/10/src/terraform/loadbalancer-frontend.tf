
resource "azurerm_public_ip" "frontend" {
  name                = "pip-lb-${var.application_name}-${var.environment_name}-frontend"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  allocation_method   = "Static"
  sku                 = "Standard"
  zones               = [1, 2, 3]
}

resource "azurerm_lb" "frontend" {
  name                = "lb-${var.application_name}-${var.environment_name}-frontend"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.frontend.id
  }
}
resource "azurerm_lb_backend_address_pool" "frontend" {
  loadbalancer_id = azurerm_lb.frontend.id
  name            = "frontend-pool"
}

resource "azurerm_lb_outbound_rule" "frontend" {
  name                    = "OutboundRule"
  loadbalancer_id         = azurerm_lb.frontend.id
  protocol                = "Tcp"
  backend_address_pool_id = azurerm_lb_backend_address_pool.frontend.id

  frontend_ip_configuration {
    name = "PublicIPAddress"
  }
}

# Connects this Virtual Machine to the Load Balancer's Backend Address Pool
resource "azurerm_network_interface_backend_address_pool_association" "frontend" {

  count = var.az_count

  network_interface_id    = azurerm_network_interface.frontend[count.index].id
  ip_configuration_name   = "internal"
  backend_address_pool_id = azurerm_lb_backend_address_pool.frontend.id

}

resource "azurerm_lb_probe" "frontend_probe_http" {
  loadbalancer_id = azurerm_lb.frontend.id
  name            = "http"
  protocol        = "Http"
  port            = 5000
  request_path    = "/"
}

resource "azurerm_lb_rule" "frontend_http" {
  loadbalancer_id                = azurerm_lb.frontend.id
  name                           = "HTTP"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 5000
  frontend_ip_configuration_name = "PublicIPAddress"
  probe_id                       = azurerm_lb_probe.frontend_probe_http.id
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.frontend.id]
  disable_outbound_snat          = true
  enable_tcp_reset               = true
  load_distribution              = "SourceIP"
}