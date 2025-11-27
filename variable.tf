variable "rgname" {
  type        = string
  description = "Resource group name"
  default     = "Greekgod-RG"
}

variable "location" {
  type        = string
  default     = "canadacentral"
}

variable "keyvault_name" {
  type        = string
  description = "Key Vault name"
  default = "greekgod-keyvault"
}

variable "SUB_ID" {
  type        = string
  description = "Azure Subscription ID"
  default = "REPLACE-WITH-YOUR-SUBSCRIPTION-ID"
}

variable "vnet_name" {
  type        = string
  description = "Virtual network name"
  default     = "greekgod-vnet"
}

variable "service_principal_name" {
  type        = string
  description = "Service principal name"
  default = "service-principal"
}

variable "kubernetes_version" {
  type        = string
  default     = ""
  description = "Kubernetes version"
}

variable "virtual_network_address_prefix" {
  type        = list(string)
  description = "VNET address prefix"
  default     = ["10.0.0.0/16"]
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