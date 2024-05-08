# variable "key_vault_name" {
#   type = string
# }
# resource "azurerm_key_vault" "tls" {
#   resource_group_name       = azurerm_resource_group.web.name
#   location                  = azurerm_resource_group.web.location
#   tags                      = azurerm_resource_group.web.tags
#   tenant_id                 = data.azurerm_client_config.main.tenant_id
#   enable_rbac_authorization = true
#   sku_name                  = "standard"
#   name                      = var.key_vault_name
# }
