variable "kubernetes_namespace_name" {
  type    = string
}

resource "kubernetes_namespace" "main" {
  metadata {
    annotations = {
      name = var.kubernetes_namespace_name
    }
    name = var.kubernetes_namespace_name
  }
}
