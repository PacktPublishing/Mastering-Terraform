resource "azurerm_user_assigned_identity" "frontend" {

  name                = "${var.application_name}-${var.environment_name}-frontend"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

}

resource "azurerm_role_assignment" "frontend_keyvault" {
  scope                = azurerm_key_vault.main.id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = azurerm_user_assigned_identity.frontend.principal_id
}

resource "azurerm_user_assigned_identity" "backend" {

  name                = "${var.application_name}-${var.environment_name}-backend"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  
}
