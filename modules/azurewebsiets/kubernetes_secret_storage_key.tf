resource "kubernetes_secret" "storage_key" {
  metadata {
    name      = "storage-account-secret"
    namespace = kubernetes_namespace.main.metadata.0.name
  }
  type = "Opaque"
  data = {
    # azurestorageaccountname = base64encode(azurerm_storage_account.web.name)
    # azurestorageaccountkey  = base64encode(azurerm_storage_account.web.primary_access_key)
    azurestorageaccountname = azurerm_storage_account.web.name
    azurestorageaccountkey  = azurerm_storage_account.web.primary_access_key
  }
}
