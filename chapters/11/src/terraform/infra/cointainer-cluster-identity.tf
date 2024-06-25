# cluster identity
resource "azurerm_user_assigned_identity" "cluster" {
  location            = azurerm_resource_group.main.location
  name                = "mi-${var.application_name}-${var.environment_name}-cluster"
  resource_group_name = azurerm_resource_group.main.name
}

resource "azurerm_role_assignment" "cluster_identity_operator" {

  scope                = azurerm_resource_group.main.id
  role_definition_name = "Managed Identity Operator"
  principal_id         = azurerm_user_assigned_identity.cluster.principal_id

}

# kubelet identity
resource "azurerm_user_assigned_identity" "cluster_kubelet" {
  location            = azurerm_resource_group.main.location
  name                = "mi-${var.application_name}-${var.environment_name}-cluster-kubelet"
  resource_group_name = azurerm_resource_group.main.name
}

# grant kubelet access to ACR
resource "azurerm_role_assignment" "cluster_kubelet_acr" {
  principal_id         = azurerm_user_assigned_identity.cluster_kubelet.principal_id
  role_definition_name = "AcrPull"
  scope                = azurerm_container_registry.main.id
}

# federated identity
resource "azurerm_federated_identity_credential" "main" {
  name                = azurerm_user_assigned_identity.cluster_kubelet.name
  resource_group_name = azurerm_resource_group.main.name
  audience            = ["foo"]
  issuer              = azurerm_kubernetes_cluster.main.oidc_issuer_url
  parent_id           = azurerm_user_assigned_identity.cluster_kubelet.id
  subject             = "system:serviceaccount:${var.k8s_namespace}:${var.k8s_service_account_name}"
}