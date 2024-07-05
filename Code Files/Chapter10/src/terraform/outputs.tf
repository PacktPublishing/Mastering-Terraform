output "frontend_public_ip_address" {
  value = azurerm_public_ip.frontend.ip_address
}

output "backend_private_ip_address" {
  value = azurerm_lb.backend.frontend_ip_configuration[0].private_ip_address
}