variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
}

variable "tenant_id" {
  description = "Azure tenant ID"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "westeurope"
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
  default     = "devsecops-rg"
}

variable "acr_name" {
  description = "Azure Container Registry name (must be globally unique)"
  type        = string
  default     = "devsecopsacr2025"
}

variable "aks_name" {
  description = "Azure Kubernetes Service name"
  type        = string
  default     = "secure-aks"
}



# variable "subscription_id" {
#   description = "Azure subscription id"
#   type        = string
#   default     = "4a39daec-4793-4d0b-9830-1f2034a4b28d"
# }

