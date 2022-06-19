resource "azurerm_dns_zone" "main" {
  resource_group_name = azurerm_resource_group.main.name
  name                = "azurewebsiets.net"
}

# resource "azurerm_dns_txt_record" "main" {
#   resource_group_name = azurerm_dns_zone.main.resource_group_name
#   zone_name = azurerm_dns_zone.main.name
#   name = "@"
#   ttl = 30
#   record {
#     value = azurerm_static_site_custom_domain.main.validation_token
#   } 
# }

# resource "azurerm_dns_a_record" "root" {
#   resource_group_name = azurerm_resource_group.main.name
#   zone_name           = azurerm_dns_zone.main.name
#   name                = "@"
#   ttl                 = 30
#   target_resource_id  = azurerm_static_site.main.id
# }

# resource "azurerm_dns_a_record" "wildcard" {
#   resource_group_name = azurerm_resource_group.main.name
#   zone_name           = azurerm_dns_zone.main.name
#   name                = "*"
#   ttl                 = 30
#   target_resource_id  = azurerm_static_site.main.id
# }