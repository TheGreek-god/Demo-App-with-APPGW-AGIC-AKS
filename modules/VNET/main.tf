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



# Network Security Group for App Gateway subnet
resource "azurerm_network_security_group" "appgw_nsg" {
  name                = "greekgod-vnet-snet-appgw-nsg-canadacentral"
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "AllowGatewayManager"
    priority                   = 2702
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "65200-65535"
    source_address_prefix      = "GatewayManager"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowHTTPInbound"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowHTTPSInbound"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    environment = "Production"
  }
}

# Network Security Group for AKS nodes subnet
resource "azurerm_network_security_group" "aks_nsg" {
  name                = "greekgod-vnet-snet-aks-nodes-nsg-canadacentral"
  location            = var.location
  resource_group_name = var.resource_group_name

  tags = {
    environment = "Production"
  }
}

# Associate NSGs with subnets
resource "azurerm_subnet_network_security_group_association" "appgw" {
  subnet_id                 = azurerm_subnet.appgw.id
  network_security_group_id = azurerm_network_security_group.appgw_nsg.id
}

resource "azurerm_subnet_network_security_group_association" "aks_nodes" {
  subnet_id                 = azurerm_subnet.aks_nodes.id
  network_security_group_id = azurerm_network_security_group.aks_nsg.id
}