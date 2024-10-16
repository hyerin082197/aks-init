data "azurerm_subnet" "aks_target_subnet" {
  name                 = var.aks_subnet_name
  virtual_network_name = var.aks_vnet_name
  resource_group_name  = var.network_resource_group_name
}

resource "azurerm_resource_group" "rg" {
  name     = var.aks_resource_group_name
  location = var.resource_group_location
}


resource "random_pet" "azurerm_kubernetes_cluster_dns_prefix" {
  prefix = "tiu-axcoe-hr-dns"  # DNS prefix를 tiu-axcoe-hr로 설정
}

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

  default_node_pool {
    name                 = "default"
    vm_size              = "Standard_DS2_v2"
    vnet_subnet_id       = data.azurerm_subnet.aks_target_subnet.id
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
