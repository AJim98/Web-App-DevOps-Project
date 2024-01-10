# networking-module output.tf
# Remember to remove exmaple and replace it with the relevant aks-rg name!

# Output for vnet
output "vnet_id" {
  description = "ID of the Virtual Network (VNet)."
  value       = azurerm_virtual_network.aks-vnet.id
}

# Output for control planet subnet
output "control_plane_subnet_id" {
    description = "ID of the control plane subnet within the VNet."
    value = azurerm_subnet.control_plane_subnet.id
}

# Output for control planet subnet
output "worker_node_subnet_id" {
    description = "ID of the worker node subnet within the VNet."
    value = azurerm_subnet.worker_node_subnet.id
}

# Output for networking resource group name
output "resource_group_name" {
    description = "Name of the Azure Resource Group for networking resources."
    value = azurerm_resource_group.networking.name
}

# Output for AKS Network Security Group
output "aks_nsg_id"{
    description = "ID of the Network Security Group (NSG) for AKS."
    value = azurerm_network_security_group.aks_nsg.id
}
