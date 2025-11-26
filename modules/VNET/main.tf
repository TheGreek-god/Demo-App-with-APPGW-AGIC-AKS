resource "azurerm_virtual_network" "aks_vnet" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.virtual_network_address_prefix

  tags = {
    environment = "Production"
  }
}


resource "azurerm_subnet" "appgw" {
  name                 = var.aks_subnet_names[0]  # "snet-appgw"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.aks_vnet.name
  address_prefixes     = [var.aks_subnets_cidr[0]]  # "10.0.1.0/24"
}

resource "azurerm_subnet" "aks_nodes" {
  name                 = var.aks_subnet_names[1]  # "snet-aks-nodes"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.aks_vnet.name
  address_prefixes     = [var.aks_subnets_cidr[1]]  # "10.0.2.0/24"
}