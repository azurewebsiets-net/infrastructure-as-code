variable "issuer_contact_email" {
  type = string
}
resource "kubernetes_manifest" "letsencrypt_staging_issuer" {
  manifest = {
    apiVersion = "cert-manager.io/v1"
    kind       = "Issuer"
    metadata = {
      name      = "letsencrypt-staging"
      namespace = kubernetes_namespace.main.metadata.0.name
    }
    spec = {
      acme = {
        server = "https://acme-staging-v02.api.letsencrypt.org/directory"
        email  = var.issuer_contact_email

        "privateKeySecretRef" = {
          name = "letsencrypt-staging"
        }

        solvers = [{
          dns01 = {
            azureDNS = {
              subscriptionID    = data.azurerm_client_config.main.subscription_id
              resourceGroupName = azurerm_resource_group.web.name
              hostedZoneName    = var.dns_zone_name
              environment       = "AzurePublicCloud"
              managedIdentity = {
                clientID = azurerm_user_assigned_identity.dns_contributor.client_id
              }
            }
          }
        }]
      }
    }
  }
}

resource "kubernetes_manifest" "letsencrypt_prod_issuer" {
  manifest = {
    apiVersion = "cert-manager.io/v1"
    kind       = "Issuer"
    metadata = {
      name      = "letsencrypt-prod"
      namespace = kubernetes_namespace.main.metadata.0.name
    }
    spec = {
      acme = {
        server = "https://acme-v02.api.letsencrypt.org/directory"
        email  = var.issuer_contact_email

        "privateKeySecretRef" = {
          name = "letsencrypt-prod"
        }

        solvers = [{
          dns01 = {
            azureDNS = {
              subscriptionID    = data.azurerm_client_config.main.subscription_id
              resourceGroupName = azurerm_resource_group.web.name
              hostedZoneName    = var.dns_zone_name
              environment       = "AzurePublicCloud"
              managedIdentity = {
                clientID = azurerm_user_assigned_identity.dns_contributor.client_id
              }
            }
          }
        }]
      }
    }
  }
}
