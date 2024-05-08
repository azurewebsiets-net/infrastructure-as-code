data "azurerm_client_config" "main" {}

resource "random_string" "suffix" {
  upper   = false
  length  = 5
  special = false
}

data "azurerm_kubernetes_cluster" "prod" {
  resource_group_name = "CACN-Cluster-Benthic-PROD-RG"
  name                = "Benthic-PROD-AKS"
}

module "azurewebsiets" {
  source               = "./modules/azurewebsiets"
  storage_account_name = "azurewebsietsweb${random_string.suffix.result}"
  # key_vault_name            = "azurewebsietsweb${random_string.suffix.result}-kv"
  kubernetes_namespace_name = "azurewebsiets"
  resource_group_name       = "CACN-ClusterWorkload-Benthic-azurewebsiets-PROD-RG"
  resource_group_location   = "canadacentral"
  dns_zone_name             = "azurewebsiets.net"
  resource_group_tags = {
    environment = "Production"
  }
  ingress_hosts = [
    "*.azurewebsiets.net",
    "azurewebsiets.net"
  ]
  issuer_contact_email              = "TeamDman9201@gmail.com"
  cluster_issuer                    = data.azurerm_kubernetes_cluster.prod.oidc_issuer_url
  cert_manager_namespace_name       = "cert-manager"
  cert_manager_service_account_name = "cert-manager"
  external_dns_service_account_name = "external-dns"
}
