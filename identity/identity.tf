terraform {
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = "4.21.1"
    }
  }
  required_version = ">= 1.10.5"
}

provider "azurerm" {
  features {
    
  }
  subscription_id = var.subscription_id
  tenant_id = var.tenant_id
}
