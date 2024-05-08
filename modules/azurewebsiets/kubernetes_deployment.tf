resource "kubernetes_deployment" "nginx" {
  metadata {
    name      = "frontend"
    labels    = local.frontend_selector
    namespace = kubernetes_namespace.main.metadata.0.name
  }
  spec {
    replicas = 1
    selector {
      match_labels = local.frontend_selector
    }
    template {
      metadata {
        labels = local.frontend_selector
        annotations = {
          "content-id" = data.local_file.index.content_md5
        }
      }
      spec {
        node_selector = {
          "kubernetes.io/os" = "linux"
        }
        container {
          image = "nginx:1.7.9"
          name  = "nginx"

          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }
          port {
            container_port = 80
          }
          # comment out the volume mount to see the default hello page
          volume_mount {
            name       = "nginx-persistent-storage"
            mount_path = "/usr/share/nginx/html"
            read_only  = true
          }
        }
        volume {
          # https://github.com/kubernetes-sigs/blob-csi-driver/blob/master/deploy/example/e2e_usage.md
          # Option#3: Inline volume
          name = "nginx-persistent-storage"
          csi {
            driver = "blob.csi.azure.com"
            volume_attributes = {
              containerName = azurerm_storage_container.web.name
              secretName    = kubernetes_secret.storage_key.metadata.0.name
              mountOptions  = "-o allow_other --file-cache-timeout-in-seconds=120"
            }
          }
        }
      }
    }
  }
}
