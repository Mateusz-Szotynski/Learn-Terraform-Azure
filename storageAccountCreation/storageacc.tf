
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.20.0"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {

  }
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
}

module "main" {
  source = "../tutorial"
}

resource "azurerm_resource_group" "rg" {
  name     = "rg2"
  location = var.location
}

resource "azurerm_storage_account" "sa-main" {
  resource_group_name      = azurerm_resource_group.rg.name
  name                     = var.storage-account-name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  blob_properties {
    versioning_enabled  = true
    change_feed_enabled = true
  }
}

resource "azurerm_storage_container" "sa-main-container" {
  storage_account_name = azurerm_storage_account.sa-main.name
  name                 = "mycontainer"
}

resource "azurerm_storage_account" "sa-backup" {
  resource_group_name      = azurerm_resource_group.rg.name
  name                     = var.storage-backup-account-name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  blob_properties {
    versioning_enabled = true
  }
}

resource "azurerm_storage_container" "sa-backup-container" {
  storage_account_name = azurerm_storage_account.sa-backup.name
  name                 = "mybackupcontainer"
}

resource "azurerm_storage_object_replication" "sa-main-to-sa-backup" {
  source_storage_account_id      = azurerm_storage_account.sa-main.id
  destination_storage_account_id = azurerm_storage_account.sa-backup.id
  rules {
    source_container_name      = azurerm_storage_container.sa-main-container.name
    destination_container_name = azurerm_storage_container.sa-backup-container.name
  }
}
