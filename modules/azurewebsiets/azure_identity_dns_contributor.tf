resource "azurerm_user_assigned_identity" "dns_contributor" {
  resource_group_name = azurerm_resource_group.web.name
  tags                = azurerm_resource_group.web.tags
  location            = azurerm_resource_group.web.location
  name                = "dns-contributor"
}

variable "cluster_issuer" {
  type = string
}
variable "cert_manager_namespace_name" {
  type = string
}
variable "cert_manager_service_account_name" {
  type = string
}
resource "azurerm_federated_identity_credential" "cert_manager" {
  resource_group_name = azurerm_resource_group.web.name
  parent_id           = azurerm_user_assigned_identity.dns_contributor.id
  name                = "cert-manager"
  issuer              = var.cluster_issuer
  # subject             = "system:serviceaccount:${kubernetes_namespace.main.metadata.0.name}:${kubernetes_service_account.dns_contributor.metadata.0.name}"
  subject             = "system:serviceaccount:${var.cert_manager_namespace_name}:${var.cert_manager_service_account_name}"
  audience            = ["api://AzureADTokenExchange"]
}

resource "azurerm_federated_identity_credential" "external_dns" {
  resource_group_name = azurerm_resource_group.web.name
  parent_id           = azurerm_user_assigned_identity.dns_contributor.id
  name                = "external-dns"
  issuer              = var.cluster_issuer
  # subject             = "system:serviceaccount:${kubernetes_namespace.main.metadata.0.name}:${kubernetes_service_account.dns_contributor.metadata.0.name}"
  subject             = "system:serviceaccount:${kubernetes_namespace.main.metadata.0.name}:${var.external_dns_service_account_name}"
  audience            = ["api://AzureADTokenExchange"]
}

data "azurerm_role_definition" "dns_contributor" {
  name = "DNS Zone Contributor"
  scope = "/subscriptions/${data.azurerm_client_config.main.subscription_id}"
}
resource "azurerm_role_assignment" "dns_contributor" {
  scope              = azurerm_dns_zone.main.id
  role_definition_id = data.azurerm_role_definition.dns_contributor.role_definition_id
  principal_id       = azurerm_user_assigned_identity.dns_contributor.principal_id
}
