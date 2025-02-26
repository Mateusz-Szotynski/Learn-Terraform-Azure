variable "resource_group_name" {
  default = "myTFResourceGroup"
}

variable "virtual_network_name" {
  default = "myTFVnet"
}

variable "location" {
  default = "west europe"
}

variable "storage-account-name" {
  description = "Name of the storage account"
}

variable "storage-backup-account-name" {
  description = "Name of the backup storage account"
}