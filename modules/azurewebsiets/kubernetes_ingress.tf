variable "ingress_hosts" {
  type = set(string)
}
resource "kubernetes_ingress_v1" "frontend" {
  metadata {
    name      = "frontend"
    namespace = kubernetes_namespace.main.metadata.0.name
    annotations = {
      "kubernetes.io/ingress.class" = "nginx"
      "cert-manager.io/issuer"      = kubernetes_manifest.letsencrypt_prod_issuer.manifest.metadata.name
    }
  }
  spec {
    ingress_class_name = "nginx"
    tls {
      hosts       = var.ingress_hosts
      secret_name = "azurewebsiets-tls"
    }
    dynamic "rule" {
      for_each = var.ingress_hosts
      content {
        host = rule.value
        http {
          path {
            path = "/"
            backend {
              service {
                name = kubernetes_service.frontend.metadata.0.name
                port {
                  number = kubernetes_service.frontend.spec.0.port.0.port
                }
              }
            }
          }
        }

      }
    }
  }
}
