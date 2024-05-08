variable "storage_account_name" {
  type    = string
}

resource "azurerm_storage_account" "web" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.web.name
  location                 = azurerm_resource_group.web.location
  tags                     = azurerm_resource_group.web.tags
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "web" {
  name                 = "webcontent"
  storage_account_name = azurerm_storage_account.web.name
}

data "local_file" "index" {
  filename = "${path.module}/content/index.html"
}

resource "azurerm_storage_blob" "index" {
  name                   = "index.html"
  source_content         = data.local_file.index.content
  storage_account_name   = azurerm_storage_account.web.name
  storage_container_name = azurerm_storage_container.web.name
  type                   = "Block"
}
