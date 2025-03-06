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

resource "azurerm_resource_group" "adds_group" {
  name = "adds_rg"
  location = var.location
  tags = {
    "Environment" = "Test"
    "Critical" = "False"
  }
}

resource "azurerm_windows_virtual_machine" "addsVM" {
  name = "addsVM"
  location = var.location
  resource_group_name = azurerm_resource_group.adds_group.name
  os_disk {
    caching = 
  }
}