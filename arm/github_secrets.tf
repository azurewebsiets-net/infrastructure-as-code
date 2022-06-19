data "github_repository" "content" {
  full_name = "azurewebsiets-net/content"
}

locals {
  secrets = {
    SERVICE_PRINCIPAL_CREDS = jsonencode({
      clientId                   = azuread_application.actions.application_id
      clientSecret               = azuread_application_password.actions.value
      tenantId                   = data.azuread_client_config.current.tenant_id
      subscriptionId             = data.azurerm_client_config.current.subscription_id
      resourceManagerEndpointUrl = "https://management.azure.com/"
    })
    STORAGE_ACCOUNT_NAME   = azurerm_storage_account.site.name
    STORAGE_CONTAINER_NAME = azurerm_storage_container.content.name
  }
}

resource "github_actions_organization_secret" "cicd" {
  for_each                = local.secrets
  selected_repository_ids = [data.github_repository.content.repo_id]
  secret_name             = each.key
  visibility              = "selected"
  plaintext_value         = each.value
}
