variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "vnet_name" {
  type        = string
  description = "Name of the virtual network"
}

variable "virtual_network_address_prefix" {
  type        = list(string)
  description = "VNET address space"
  default     = ["10.0.0.0/16"]
}

variable "appgw_subnet_cidr" {
  type        = string
  description = "CIDR for Application Gateway subnet"
  default     = "10.0.1.0/24"
}

variable "aks_subnet_cidr" {
  type        = string
  description = "CIDR for AKS node pool subnet"
  default     = "10.0.2.0/24"
}

variable "aks_subnets_cidr" {
  type        = list(string)
  description = "AKS subnet CIDR ranges"
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "aks_subnet_names" {
  type        = list(string)
  description = "AKS subnet names"
  default     = ["snet-appgw", "snet-aks-nodes"]
}
