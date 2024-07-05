
data "azurerm_image" "backend" {
  name                = var.backend_image.name
  resource_group_name = var.backend_image.resource_group_name
}

resource "azurerm_network_interface" "backend" {

  count = var.az_count

  name                = "nic-${var.application_name}-${var.environment_name}-backend${count.index}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.backend.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface_application_security_group_association" "backend" {

  count = var.az_count

  network_interface_id          = azurerm_network_interface.backend[count.index].id
  application_security_group_id = azurerm_application_security_group.backend.id

}

resource "azurerm_linux_virtual_machine" "backend" {

  count = var.az_count

  name                = "vm-${var.application_name}-${var.environment_name}-backend${count.index}"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  size                = "Standard_F2"
  admin_username      = var.admin_username
  zone                = count.index + 1

  network_interface_ids = [
    azurerm_network_interface.backend[count.index].id
  ]

  admin_ssh_key {
    username   = var.admin_username
    public_key = tls_private_key.ssh.public_key_openssh
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_id = data.azurerm_image.backend.id

}
