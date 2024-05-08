variable "external_dns_service_account_name" {
  type = string
}
# resource "helm_release" "external_dns" {
#   repository = "https://charts.bitnami.com/bitnami"
#   chart      = "external-dns"
#   version    = "v7.2.3"
#   namespace  = kubernetes_namespace.main.metadata.0.name
#   name       = "external-dns"
#   set {
#     name  = "provider"
#     value = "azure"
#   }
#   set {
#     name  = "policy"
#     value = "sync"
#   }
#   set_list {
#     name  = "domainFilters"
#     value = var.ingress_hosts
#   }
#   set {
#     name  = "azure.resourceGroup"
#     value = azurerm_resource_group.web.name
#   }
#   set {
#     name  = "azure.subscriptionId"
#     value = data.azurerm_client_config.main.subscription_id
#   }
#   set {
#     name  = "azure.tenantId"
#     value = data.azurerm_client_config.main.tenant_id
#   }
#   set {
#     name  = "azure.useWorkloadIdentityExtension"
#     value = "true"
#   }
#   # set {
#   #   name  = "azure.userAssignedIdentityID"
#   #   value = azurerm_user_assigned_identity.dns_contributor.client_id
#   # }
#   set {
#     name = "serviceAccount.name"
#     value = var.external_dns_service_account_name
#   }
# }
