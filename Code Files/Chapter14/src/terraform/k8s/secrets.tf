/*
resource "helm_release" "csi_secrets_store" {

  name       = "csi-secrets-store"
  repository = "https://kubernetes-sigs.github.io/secrets-store-csi-driver/charts"
  chart      = "secrets-store-csi-driver"
  namespace  = "kube-system"

  set {
    name  = "syncSecret.enabled"
    value = "true"
  }

}
*/

/*
resource "helm_release" "gcp_secrets_provider" {

  name       = "secrets-store-csi-driver-provider-gcp"
  repository = "https://googlecloudplatform.github.io/secrets-store-csi-driver-provider-gcp"
  chart      = "secrets-store-csi-driver-provider-gcp"
  namespace  = "kube-system"

}
*/
#helm upgrade --install secrets-store-csi-driver-provider-gcp charts/secrets-store-csi-driver-provider-gcp