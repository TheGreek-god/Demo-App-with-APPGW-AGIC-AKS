variable "location" {
  type        = string
  description = "Azure region"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "service_principal_name" {
  type        = string
  description = "Service principal name"
}

variable "ssh_public_key" {
  type        = string
  default     = "~/.ssh/id_rsa.pub"
  description = "SSH public key path"
}

variable "client_id" {
  type        = string
  description = "Service principal client ID"
}

variable "client_secret" {
  type        = string
  sensitive   = true
  description = "Service principal client secret"
}

# ✅ ADD THIS MISSING VARIABLE
variable "aks_subnet_id" {
  type        = string
  description = "Subnet ID for AKS cluster"
}