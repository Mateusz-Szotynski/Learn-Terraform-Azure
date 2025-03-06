terraform {
    required_providers {
        azurerm = {
            source = "hashicorp/azurerm"
            version = "4.21.1"
        }
    }
}

provider "azurerm" {
  features {
    
  }
  tenant_id = var.tenant_id
  subscription_id = var.subscription_id
}

resource "azurerm_key_vault" "akv" {
  name = "akv"
  location = var.location
  resource_group_name = 
}