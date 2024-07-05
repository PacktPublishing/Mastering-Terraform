
locals {
  web_app_name = "fleet-portal"
}

resource "kubernetes_deployment" "web_app" {
  metadata {
    name      = local.web_app_name
    namespace = var.k8s_namespace
  }

  spec {
    replicas = 3

    selector {
      match_labels = {
        app = local.web_app_name
      }
    }

    template {
      metadata {
        labels = {
          app = local.web_app_name
        }
      }

      spec {
        container {
          image = "${var.primary_region}-docker.pkg.dev/${var.gcp_project}/${var.web_app_image.name}:${var.web_app_image.version}"
          name  = local.web_app_name
          port {
            container_port = 5000
          }
          env_from {
            config_map_ref {
              name = kubernetes_config_map.web_app.metadata.0.name
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "web_app" {
  metadata {
    name      = "${local.web_app_name}-service"
    namespace = var.k8s_namespace
  }
  spec {
    type = "ClusterIP"
    port {
      port        = 80
      target_port = 5000
    }
    selector = {
      app = local.web_app_name
    }
  }
}

resource "kubernetes_config_map" "web_app" {
  metadata {
    name      = "${local.web_app_name}-config"
    namespace = var.k8s_namespace
  }

  data = {
    BackendEndpoint = ""
  }
}
