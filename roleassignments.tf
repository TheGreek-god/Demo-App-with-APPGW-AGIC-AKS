resource "azurerm_role_assignment" "ra1" {
  scope                = azurerm_resource_group.rg.id
  role_definition_name = "Contributor"
  principal_id         = module.serviceprincipal.service_principal_object_id
}

resource "azurerm_role_assignment" "ra2" {
  scope                = module.vnet.vnet_id
  role_definition_name = "Network Contributor"
  principal_id         = module.serviceprincipal.service_principal_object_id
}

resource "azurerm_role_assignment" "ra3" {
  scope                = module.appgw.appgw_id
  role_definition_name = "Contributor"
  principal_id         = module.serviceprincipal.service_principal_object_id
}

resource "azurerm_role_assignment" "keyvault_secrets" {
  scope                = module.keyvault.keyvault_id
  role_definition_name = "Key Vault Secrets Officer"
  principal_id         = module.serviceprincipal.service_principal_object_id
  depends_on           = [module.keyvault]
}