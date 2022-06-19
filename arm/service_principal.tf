# resource "azuread_application" "dns" {
#   display_name = "azurewebsiets-aks-dns"
#   owners       = [data.azuread_client_config.current.object_id]
# }

# resource "azuread_application_password" "dns_password" {
#   application_object_id = azuread_application.dns.object_id
# }
# output "external_dns" {
#   sensitive = true
#   value = {
#     subscriptionId  = data.azurerm_client_config.current.subscription_id
#     tenantId        = data.azurerm_client_config.current.tenant_id
#     resourceGroup   = azurerm_resource_group.main.name
#     aadClientId     = azuread_application.dns.application_id
#     aadClientSecret = azuread_application_password.dns_password.value
#   }
# }


# resource "azuread_service_principal" "dns" {
#   application_id = azuread_application.dns.application_id
#   owners         = azuread_application.dns.owners
# }

resource "azurerm_role_assignment" "dns" {
  # principal_id         = data.azurerm_kubernetes_cluster.main.identity[0].principal_id
  principal_id         = data.azurerm_kubernetes_cluster.main.kubelet_identity[0].object_id
  scope                = azurerm_dns_zone.main.id
  role_definition_name = "DNS Zone Contributor"
}