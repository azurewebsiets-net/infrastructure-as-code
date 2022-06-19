data "github_repository" "content" {
  full_name = "azurewebsiets-net/content"
}

locals {
  secrets = {
    AZURE_STATIC_WEB_APPS_API_TOKEN = azurerm_static_site.main.api_key
  }
}

resource "github_actions_organization_secret" "cicd" {
  for_each                = local.secrets
  selected_repository_ids = [data.github_repository.content.repo_id]
  secret_name             = each.key
  visibility              = "selected"
  plaintext_value         = each.value
}
