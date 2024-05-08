resource "kubernetes_service_account" "dns_contributor" {
  metadata {
    name = "dns-contributor-workload-identity"
    namespace = kubernetes_namespace.main.metadata.0.name
    labels = {
      "azure.workload.identity/use" = "true"
    }
    annotations = {
        "azure.workload.identity/client-id": azurerm_user_assigned_identity.dns_contributor.client_id
        "azure.workload.identity/tenant-id": azurerm_user_assigned_identity.dns_contributor.tenant_id
    }
  }
}