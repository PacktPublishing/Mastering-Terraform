
resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
# do
resource "azurerm_key_vault_secret" "ssh_private_key" {
  name         = "ssh-private-key"
  value        = tls_private_key.ssh.private_key_openssh
  key_vault_id = azurerm_key_vault.main.id

  depends_on = [azurerm_role_assignment.terraform_keyvault]
}
resource "azurerm_key_vault_secret" "ssh_public_key" {
  name         = "ssh-public-key"
  value        = tls_private_key.ssh.public_key_pem
  key_vault_id = azurerm_key_vault.main.id

  depends_on = [azurerm_role_assignment.terraform_keyvault]
}
