source "azure-arm" "vm" {
  client_id       = var.arm_client_id
  client_secret   = var.arm_client_secret
  subscription_id = var.arm_subscription_id
  tenant_id       = var.arm_tenant_id

  location                          = var.azure_primary_location
  managed_image_name                = "${var.image_name}-${var.image_version}"
  managed_image_resource_group_name = var.resource_group_name
  image_offer                       = "0001-com-ubuntu-server-jammy"
  image_publisher                   = "canonical"
  image_sku                         = "22_04-lts"

  communicator                      = "ssh"
  os_type                           = "Linux"
  vm_size                           = var.vm_size
  allowed_inbound_ip_addresses      = [var.agent_ipaddress]

}