# 리소스 그룹 생성
resource "azurerm_resource_group" "rg" {
  name     = var.aks_resource_group_name
  location = var.resource_group_location
}

# 가상 네트워크 생성
resource "azurerm_virtual_network" "aks_vnet" {
  name                = var.aks_vnet_name
  address_space       = ["10.28.0.0/16"]
  location            = var.resource_group_location
  resource_group_name = var.aks_resource_group_name
}

# 서브넷 생성
resource "azurerm_subnet" "aks_subnet" {
  name                 = var.aks_subnet_name
  resource_group_name = var.aks_resource_group_name
  virtual_network_name = azurerm_virtual_network.aks_vnet.name
  address_prefixes     = ["10.28.0.0/24"]
}

# DNS prefix 생성
resource "random_pet" "azurerm_kubernetes_cluster_dns_prefix" {
  prefix = "tiu-axcoe-hr-dns"  # DNS prefix를 tiu-axcoe-hr로 설정
}

# AKS 클러스터 생성
resource "azurerm_kubernetes_cluster" "k8s_cluster" {
  location            = var.resource_group_location
  name                = var.aks_cluster_name
  resource_group_name = var.aks_resource_group_name
  node_resource_group = var.aks_node_resource_group_name
  dns_prefix          = random_pet.azurerm_kubernetes_cluster_dns_prefix.id
  kubernetes_version  = "1.29.7"

  identity {
    type = "SystemAssigned"
  }

  resource "azurerm_public_ip" "aks_public_ip" {
  name                = "${var.aks_resource_group_name}-public-ip"
  location            = var.resource_group_location
  resource_group_name = var.aks_resource_group_name
  allocation_method   = "Dynamic"
  sku                 = "Standard"
}

  default_node_pool {
    name                 = "default"
    vm_size              = "Standard_DS2_v2"
    vnet_subnet_id       = azurerm_subnet.aks_subnet.id  # 직접 생성한 서브넷을 참조
    node_count           = var.default_node_count
    orchestrator_version = "1.29.7"
  }

  linux_profile {
    admin_username = var.username

    ssh_key {
      key_data = azapi_resource_action.ssh_public_key_gen.output.publicKey
    }
  }

  network_profile {
    network_plugin    = "kubenet"
    load_balancer_sku = "standard"
    pod_cidr          = var.aks_pod_cidr
    service_cidr      = var.aks_service_cidr
    dns_service_ip    = var.aks_dns_service_ip
  }
}
