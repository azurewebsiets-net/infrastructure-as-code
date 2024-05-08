resource "kubernetes_service" "frontend" {
  metadata {
    name = "frontend"
    namespace = kubernetes_namespace.main.metadata.0.name
  }
  spec {
    port {
      port = 80
    }
    selector = local.frontend_selector
  }
}