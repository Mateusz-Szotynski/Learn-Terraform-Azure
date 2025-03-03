terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.21.1"
    }
  }
  required_version = ">= 1.10.5"
}

provider "azurerm" {
  features {

  }
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
}

resource "azurerm_resource_group" "rg" {
  name     = "devops-project"
  location = var.location
}

resource "azurerm_virtual_network" "vnet" {
  name                = "devopsnetwork"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "subnet1" {
  name                 = "devopssubnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_watcher" "watcher" {
  name                = "devops-network-watcher"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_network_interface" "myvmnic" {
  name                = "myLinuxVMNIC"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  ip_configuration {
    name                          = "internal"
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.subnet1.id
  }
}

resource "azurerm_linux_virtual_machine" "myvm" {
  name                  = "myLinuxVM"
  location              = var.location
  resource_group_name   = azurerm_resource_group.rg.name
  size                  = "Standard_A1_v2"
  network_interface_ids = [azurerm_network_interface.myvmnic.id]
  admin_username        = "szotma"

  admin_ssh_key {
    username   = "szotma"
    public_key = file("C:/Users/mateu/.ssh/id_ed25519.pub")
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  source_image_reference {
    publisher = "oracle"
    offer     = "oracle-linux"
    sku       = "ol94-lvm"
    version   = "latest"
  }
}

resource "azurerm_storage_account" "storage_account" {
  name                     = "myscvscsdjafhjfw"
  location                 = var.location
  resource_group_name      = azurerm_resource_group.rg.name
  account_replication_type = "LRS"
  account_tier             = "Standard"
}