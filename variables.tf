variable "resource_group_location" {
  type        = string
  default     = "koreacentral"  # 지역 설정 (한국 중부)
}

variable "prefix" {
  type        = string
  default     = "tiu-axcoe-hr"  # 모든 리소스에 사용될 prefix
}

# 네트워크 관련 리소스 그룹 및 네이밍
variable "network_resource_group_name" {
  type        = string
  default     = "${var.prefix}-net-rg"  # 네트워크 리소스 그룹 이름
}

# AKS 관련 리소스 그룹 및 네이밍
variable "aks_resource_group_name" {
  type        = string
  default     = "${var.prefix}-aks-rg"  # AKS 리소스 그룹 이름
}

variable "aks_node_resource_group_name" {
  type        = string
  default     = "${var.prefix}-aks-nodes-rg"  # AKS 노드 리소스 그룹 이름
}

variable "aks_cluster_name" {
  type        = string
  default     = "${var.prefix}-aks"  # AKS 클러스터 이름
}

# 공통 자원 관련 리소스 그룹 및 ACR 네이밍
variable "common_resource_group_name" {
  type        = string
  default     = "${var.prefix}-com-rg"  # 공통 리소스 그룹 이름
}

variable "common_base_acr_name" {
  type        = string
  default     = "${var.prefix}basecr"  # 기본 ACR 이름
}

variable "common_app_acr_name" {
  type        = string
  default     = "${var.prefix}appcr"  # 앱 ACR 이름
}

# 네트워크 및 서브넷 관련 변수
variable "aks_vnet_name" {
  type        = string
  default     = "${var.prefix}-vnet"
}

variable "aks_subnet_name" {
  type        = string
  default     = "${var.prefix}-aks-snet"
}

variable "aks_subnet_nsg_name" {
  type        = string
  default     = "${var.prefix}-nsg"
}

# AKS 클러스터 네트워크 설정
variable "aks_pod_cidr" {
  type        = string
  default     = "172.22.0.0/16"
}

variable "aks_service_cidr" {
  type        = string
  default     = "192.168.132.0/24"  # 서비스 CIDR 설정
}

variable "aks_dns_service_ip" {
  type        = string
  default     = "192.168.132.10"  # DNS 서비스 IP
}

# 노드 풀 관련 설정
variable "default_node_count" {
  type        = number
  default     = 1  # 기본 노드 수
}

# variable "devops_node_count" {
#  type        = number
#  default     = 1  # DevOps 노드 수
# }


variable "username" {
  type        = string
  default     = "azureadmin"
}
