variable "vnet_name" {
  type        = string
  description = "greekgod-vnet"
}

variable "location" {
  type        = string
  description = "canadacentral"
}

variable "resource_group_name" {
  type        = string
  description = "Greekgod-RG"
}

variable "service_principal_name" {
  type = string
}
variable "appgw_subnet_id" {
  type        = string
  description = "Subnet ID for Application Gateway"
}