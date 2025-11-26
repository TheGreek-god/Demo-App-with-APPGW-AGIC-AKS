output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "client_id" {
  description = "The application id of AzureAD application created."
  value       = module.serviceprincipal.client_id
}

output "client_secret" {
  description = "Password for service principal."
  value       = module.serviceprincipal.client_secret
  sensitive = true

}