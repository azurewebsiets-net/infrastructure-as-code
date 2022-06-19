resource "azurerm_resource_group" "main" {
  name     = "net.azurewebsiets"
  location = "canadaeast"
  tags = {
    "Web-Domain" = "azurewebsiets.net"
    "Web-FQDN"   = "azurewebsiets.net"
  }
}