variable "location" {
  default     = "west europe"
  description = "location of a resource"
}

variable "storage-account-name" {
  description = "Name of the storage account"
  type        = string
  nullable    = false
  validation {
    condition     = length(var.storage-account-name) >= 4 && length(var.storage-account-name) <= 24
    error_message = "Name must be valid"
  }
}

variable "storage-backup-account-name" {
  description = "Name of the backup storage account"
  type        = string
  nullable    = false
  validation {
    condition     = length(var.storage-backup-account-name) >= 4 && length(var.storage-backup-account-name) <= 24
    error_message = "Name must be valid"
  }
}
