output "vnet_id" {
  description = "Virtual Network ID"
  value       = azurerm_virtual_network.aks_vnet.id
}

# ✅ CORRECT: Reference the actual subnet resources you created
output "appgw_subnet_id" {
  description = "Application Gateway subnet ID"
  value       = azurerm_subnet.appgw.id  # Matches your appgw subnet
}

output "aks_subnet_id" {
  description = "AKS node pool subnet ID"  
  value       = azurerm_subnet.aks_nodes.id  # Matches your aks_nodes subnet
}