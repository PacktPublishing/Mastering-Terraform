
locals {
  web_api_name = "fleet-api"
}

resource "kubernetes_deployment" "web_api" {
  metadata {
    name      = local.web_api_name
    namespace = var.k8s_namespace
  }

  spec {
    replicas = 3

    selector {
      match_labels = {
        app = local.web_api_name
      }
    }

    template {
      metadata {
        labels = {
          app = local.web_api_name
        }
      }

      spec {
        service_account_name = kubernetes_service_account.workload_identity.metadata[0].name

        volume {
          name = "secrets-store-inline"
          csi {
            driver    = "secrets-store.csi.k8s.io"
            read_only = true
            volume_attributes = {
              "secretProviderClass" = kubernetes_manifest.secret_provider_class.manifest.metadata.name
            }
          }
        }

        container {
          image = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.primary_region}.amazonaws.com/${var.web_api_image.name}:${var.web_api_image.version}"
          name  = local.web_api_name

          port {
            container_port = 5000
          }

          volume_mount {
            name       = "secrets-store-inline"
            mount_path = "/mnt/secrets-store"
            read_only  = true
          }

          env_from {
            config_map_ref {
              name = kubernetes_config_map.web_api.metadata.0.name
            }
          }
          env {
            name = "DB_CONNECTION_STRING"
            value_from {
              secret_key_ref {
                name = "fleet-portal-dev-connection-string"
                key  = "fleet-portal-dev-connection-string"
              }
            }
          }
        }
      }
    }
  }

  timeouts {
    create = "15m"
    update = "15m"
    delete = "5m"
  }
}

resource "kubernetes_service" "web_api" {
  metadata {
    name      = "${local.web_api_name}-service"
    namespace = var.k8s_namespace

  }
  spec {
    type = "ClusterIP"
    port {
      port        = 80
      target_port = 5000
    }
    selector = {
      app = local.web_api_name
    }
  }
}

resource "kubernetes_config_map" "web_api" {
  metadata {
    name      = "${local.web_api_name}-config"
    namespace = var.k8s_namespace
  }

  data = {
    BackendEndpoint = ""
  }
}
