resource "azurerm_resource_group" "rg" {
  name     = var.rgname
  location = var.location
}

module "serviceprincipal" {
  source                 = "./modules/serviceprincipal"
  service_principal_name = var.service_principal_name
  depends_on             = [azurerm_resource_group.rg]
}

resource "azurerm_role_assignment" "rolespn" {
  scope                = "/subscriptions/${var.SUB_ID}"
  role_definition_name = "Contributor"
  principal_id         = module.serviceprincipal.service_principal_object_id
  depends_on           = [module.serviceprincipal]
}

# Create Virtual Network and Subnets - FIXED
module "vnet" {
  source                       = "./modules/vnet"
  vnet_name                    = var.vnet_name
  virtual_network_address_prefix = var.virtual_network_address_prefix
  location                     = var.location
  resource_group_name          = var.rgname
  appgw_subnet_cidr            = var.aks_subnets_cidr[0]  # "10.0.1.0/24"
  aks_subnet_cidr              = var.aks_subnets_cidr[1]  # "10.0.2.0/24"
  depends_on                   = [azurerm_resource_group.rg]
}

module "keyvault" {
  source                      = "./modules/keyvault"
  keyvault_name               = var.keyvault_name
  location                    = var.location
  resource_group_name         = var.rgname
  service_principal_name      = var.service_principal_name
  service_principal_object_id = module.serviceprincipal.service_principal_object_id
  service_principal_tenant_id = module.serviceprincipal.service_principal_tenant_id
  depends_on                  = [module.serviceprincipal]
}

resource "azurerm_key_vault_secret" "example" {
  name         = module.serviceprincipal.client_id
  value        = module.serviceprincipal.client_secret
  key_vault_id = module.keyvault.keyvault_id
  depends_on   = [module.keyvault]
}

# Create Application Gateway
module "appgw" {
  source                 = "./modules/appgw"
  location               = var.location
  resource_group_name    = var.rgname
  vnet_name              = var.vnet_name
  service_principal_name = var.service_principal_name
  appgw_subnet_id        = module.vnet.appgw_subnet_id
  depends_on             = [module.vnet]
}

# Create Azure Kubernetes Service
module "aks" {
  source                 = "./modules/AKS/"
  service_principal_name = var.service_principal_name
  client_id              = module.serviceprincipal.client_id
  client_secret          = module.serviceprincipal.client_secret
  location               = var.location
  resource_group_name    = var.rgname
  aks_subnet_id          = module.vnet.aks_subnet_id
  depends_on             = [module.serviceprincipal, module.vnet]
}

resource "local_file" "kubeconfig" {
  depends_on = [module.aks]
  filename   = "./kubeconfig"
  content    = module.aks.config
}