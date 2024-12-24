variable "resource_group_location" {
  type        = string
  default     = "koreacentral"
}

variable "prefix" {
  type = string
  default = "tiu-axcoe-hr"
}

variable "network_resource_group_name" {
  type        = string
  default     = "tiu-axcoe-hr-net-rg"
}

variable "aks_resource_group_name" {
  type        = string
  default     = "tiu-axcoe-hr-aks-rg"
}

variable "aks_node_resource_group_name" {
  type        = string
  default     = "tiu-axcoe-hr-aks-mc-rg"
}

variable "aks_cluster_name" {
  type        = string
  default     = "tiu-axcoe-hr-aks"
}

variable "common_resource_group_name" {
  type        = string
  default     = "tiu-axcoe-hr-com-rg"
}

variable "common_base_acr_name" {
  type        = string
  default     = "tiuaxcoebasecr"
}

variable "common_app_acr_name" {
  type        = string
  default     = "tiuaxcoeappcr"
}

variable "aks_vnet_name" {
  type = string
  default = "tiu-axcoe-hr-vnet"
}

variable "aks_subnet_name" {
  type = string
  default = "tiu-axcoe-hr-aks-snet"
}

variable "aks_subnet_nsg_name" {
  type = string
  default = "tiu-axcoe-hr-nsg"
}

variable "aks_pod_cidr" {
  type = string
  default = "10.28.1.0/24"
}

variable "aks_service_cidr" {
  type = string
  default = "10.28.2.0/24"
}

variable "aks_dns_service_ip" {
  type = string
  default = "10.28.2.10"
}

variable "default_node_count" {
  type        = number
  default     = 1
}

variable "devops_node_count" {
  type        = number
  default     = 1
}

variable "username" {
  type        = string
  default     = "azureadmin"
}

variable "network_dataplane" {
  type    = string
  default = "cilium"
}