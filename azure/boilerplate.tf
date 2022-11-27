terraform {
  backend "azurerm" {
    resource_group_name  = "Terraform"
    storage_account_name = "terraform9201"
    container_name       = "tfstate"
    key                  = "net.azurewebsiets.tfstate"
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.10.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = ">=2.24.0"
    }
    github = {
      source  = "integrations/github"
      version = ">=4.26.1"
    }
  }
}

locals {
  dotenv = { for tuple in regexall("(.*)=(.*)", file(".env")) : tuple[0] => tuple[1] }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}


provider "github" {
  owner = "azurewebsiets-net"
  token = local.dotenv.github_token
}

data "azurerm_client_config" "current" {

}

data "azuread_client_config" "current" {

}


data "azurerm_kubernetes_cluster" "main" {
  resource_group_name = "ca.teamdman"
  name                = "teamdman-aks"
}