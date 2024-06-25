locals {
  web_api_name = "fleet-api"
}

resource "kubernetes_deployment" "web_api" {
  metadata {
    name      = local.web_api_name
    namespace = var.namespace
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
        node_selector = {
          "agentpool" = "workloadpool"
        }
        container {
          image = "${var.registry_endpoint}/${var.web_api_image.name}:${var.web_api_image.version}"
          name  = local.web_api_name
          port {
            container_port = 5000
          }
        }
        toleration {
          key      = "workload"
          operator = "Equal"
          value    = "true"
          effect   = "NoSchedule"
        }
      }
    }
  }
}

resource "kubernetes_service" "web_api" {
  metadata {
    name      = "${local.web_api_name}-service"
    namespace = var.namespace
  }
  spec {
    type = "LoadBalancer"
    port {
      port        = 80
      target_port = 5000
    }
    selector = {
      app = local.web_api_name
    }
  }
}