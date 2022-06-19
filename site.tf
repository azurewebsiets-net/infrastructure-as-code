resource "azurerm_static_site" "main" {
  resource_group_name = azurerm_resource_group.main.name
  location = "eastus2"
  name="net-azurewebsiets"
  
}

resource "azurerm_static_site_custom_domain" "main" {
  static_site_id = azurerm_static_site.main.id
  domain_name = "azurewebsiets.net"
  validation_type = "dns-txt-token"
}