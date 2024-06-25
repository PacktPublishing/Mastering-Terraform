resource "random_password" "database_admin" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "azurerm_postgresql_server" "main" {
  name                = "psql-${var.application_name}-${var.environment_name}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  sku_name                     = "B_Gen5_2"
  storage_mb                   = 5120
  backup_retention_days        = 7
  geo_redundant_backup_enabled = false
  auto_grow_enabled            = true
  administrator_login          = var.database_admin_username
  administrator_login_password = random_password.database_admin.result
  version                      = "9.5"
  ssl_enforcement_enabled      = true
}

resource "azurerm_postgresql_database" "main" {
  name                = "psqldb-${var.application_name}-${var.environment_name}"
  resource_group_name = azurerm_resource_group.main.name
  server_name         = azurerm_postgresql_server.main.name
  charset             = "UTF8"
  collation           = "English_United States.1252"
}

resource "azurerm_key_vault_secret" "database_admin_password" {
  name         = "db-admin-password"
  value        = random_password.database_admin.result
  key_vault_id = azurerm_key_vault.main.id
}
