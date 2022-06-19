resource "azurerm_storage_account" "site" {
  resource_group_name      = azurerm_resource_group.main.name
  location                 = "canadaeast"
  name                     = "azurewebsiets"
  account_replication_type = "LRS"
  account_tier             = "Standard"
}

resource "azurerm_storage_container" "content" {
  storage_account_name = azurerm_storage_account.site.name
  name                 = "content"
}


data "azurerm_kubernetes_cluster" "main" {
  resource_group_name = "shared-cluster"
  name                = "shared-cluster"
}

resource "azurerm_role_assignment" "clusterstorage" {
  principal_id         = data.azurerm_kubernetes_cluster.main.identity[0].principal_id
  scope                = azurerm_storage_account.site.id
  role_definition_name = "Contributor"
}
