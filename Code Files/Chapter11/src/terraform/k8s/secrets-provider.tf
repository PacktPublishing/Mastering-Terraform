resource "kubernetes_manifest" "secret_provider_class" {
  manifest = {
    apiVersion = "secrets-store.csi.x-k8s.io/v1"
    kind       = "SecretProviderClass"
    metadata = {
      name      = "web-app-secrets"
      namespace = var.namespace
    }
    spec = {
      provider = "azure"
      secretObjects = [
        {
          data = [
            {
              key        = "db-admin-password"
              objectName = "db-admin-password"
            }
          ]
          secretName = "cart"
          type       = "Opaque"
        }
      ]
      parameters = {
        usePodIdentity = "false"
        clientID       = var.service_account_client_id
        keyvaultName   = var.keyvault_name
        cloudName      = ""
        objects = yamlencode([
          {
            objectName    = "db-admin-password"
            objectType    = "secret"
            objectVersion = ""
          }
        ])
        tenantId = var.tenant_id
      }
    }
  }
}
