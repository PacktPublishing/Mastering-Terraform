output "keyvault_name" {
  value = azurerm_key_vault.main.name
}
output "kube_config_raw" {
  value     = azurerm_kubernetes_cluster.main.kube_config_raw
  sensitive = true
}
output "oidc_issuer_url" {
  value = azurerm_kubernetes_cluster.main.oidc_issuer_url
}
output "service_account_client_id" {
  value = azurerm_user_assigned_identity.cluster_kubelet.client_id
}
output "registry_endpoint" {
  value = azurerm_container_registry.main.login_server
}
output "tenant_id" {
  value = data.azurerm_client_config.current.tenant_id
}