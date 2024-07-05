resource "kubernetes_namespace" "main" {
  metadata {
    name = var.namespace
    labels = {
      name = var.namespace
    }
  }
}