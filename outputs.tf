output "resource_group_id" {
  value = azurerm_resource_group.rg.id
}

output "vnet_address_space" {
  value = azurerm_virtual_network.vnet.address_space
}
