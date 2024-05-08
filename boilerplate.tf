terraform {
  backend "azurerm" {
    subscription_id      = "6cb7032f-2437-4f5e-91e8-676cb67e5444"
    resource_group_name  = "CACN-Terraform-PROD-RG"
    storage_account_name = "terraformproddwvc87"
    container_name       = "statefiles"
    key                  = "azurewebsiets.tfstate"
  }
}

provider "azurerm" {
  features {}
  subscription_id = "6cb7032f-2437-4f5e-91e8-676cb67e5444"
}

provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "Benthic-PROD-AKS"
}

provider "helm" {
  kubernetes {
    config_path    = "~/.kube/config"
    config_context = "Benthic-PROD-AKS"
  }
}
