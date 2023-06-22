terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.55.0"
    }
  }

  // update the values here if not already configured elsewhere
  backend "azurerm" {
    # resource_group_name     = 
    # storage_account_name    = 
    # container_name          =
    key      = "tfstate"
    use_oidc = true
  }
}

provider "azurerm" {
  features {}
  use_oidc = true
}