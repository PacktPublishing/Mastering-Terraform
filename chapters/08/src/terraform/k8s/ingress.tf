resource "kubernetes_ingress_v1" "ingress" {
  metadata {
    name      = "${local.web_app_name}-ingress"
    namespace = var.k8s_namespace
    annotations = {
      "kubernetes.io/ingress.class" = "nginx"
    }
  }
  spec {
    rule {
      http {
        path {
          path      = "/"
          path_type = "Prefix"

          backend {
            service {
              name = kubernetes_service.web_app.metadata[0].name
              port {
                number = 80
              }
            }
          }
        }
        path {
          path      = "/api"
          path_type = "Prefix"

          backend {
            service {
              name = kubernetes_service.web_api.metadata[0].name
              port {
                number = 80
              }
            }
          }
        }
      }
    }
  }

  depends_on = [
    kubernetes_service.web_app,
    /*kubernetes_service.web_api,*/
    helm_release.ingress
  ]
}