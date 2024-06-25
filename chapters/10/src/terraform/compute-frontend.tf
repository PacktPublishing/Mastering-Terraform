
data "azurerm_image" "frontend" {
  name                = var.frontend_image.name
  resource_group_name = var.frontend_image.resource_group_name
}

resource "azurerm_network_interface" "frontend" {

  count = var.az_count

  name                = "nic-${var.application_name}-${var.environment_name}-frontend${count.index}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.frontend.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface_application_security_group_association" "frontend" {

  count = var.az_count

  network_interface_id          = azurerm_network_interface.frontend[count.index].id
  application_security_group_id = azurerm_application_security_group.frontend.id

}

resource "azurerm_linux_virtual_machine" "frontend" {

  count = var.az_count

  name                = "vm-${var.application_name}-${var.environment_name}-frontend${count.index}"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  size                = "Standard_F2"
  admin_username      = var.admin_username
  zone                = count.index + 1

  network_interface_ids = [
    azurerm_network_interface.frontend[count.index].id
  ]

  admin_ssh_key {
    username   = var.admin_username
    public_key = tls_private_key.ssh.public_key_openssh
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_id = data.azurerm_image.frontend.id
  user_data       = data.cloudinit_config.frontend.rendered

}

data "cloudinit_config" "frontend" {
  gzip          = false
  base64_encode = true

  part {
    content_type = "text/cloud-config"
    content      = <<-EOF
                   #cloud-config
                   write_files:
                     - path: /etc/profile.d/backend_endpoint.sh
                       content: |
                         export DOTNET_BACKEND_ENDPOINT="http://${azurerm_lb.backend.frontend_ip_configuration[0].private_ip_address}"
                   EOF
  }
  part {
    filename     = "1-update-service.sh"
    content_type = "text/x-shellscript"
    content      = <<-EOF
      #!/bin/bash
      sed -i 's|BACKEND_PLACEHOLDER|${azurerm_lb.backend.frontend_ip_configuration[0].private_ip_address}|g' /etc/systemd/system/myblazorapp.service
      systemctl daemon-reload
      systemctl restart myblazorapp.service
    EOF
  }
}
