resource "azurerm_kubernetes_cluster" "pizzastore" {
  name                = "pizzastore"
  location            = "eastus"
  resource_group_name = azurerm_resource_group.pizzastore.name
  node_resource_group = "MC_rg-pizzastore-dev_pizzastore_eastus"

  dns_prefix         = "pizzastore-dns"
  kubernetes_version = "1.37.1"
  sku_tier           = "Free"

  automatic_upgrade_channel = "patch"

  private_cluster_enabled = false

  role_based_access_control_enabled = true

  oidc_issuer_enabled       = true
  workload_identity_enabled = true

  image_cleaner_enabled        = true
  image_cleaner_interval_hours = 168

  default_node_pool {
    name            = "agentpool"
    type            = "VirtualMachineScaleSets"
    node_count      = 1
    zones           = ["1", "2", "3"]
    vm_size         = "Standard_D2as_v4"
    max_pods        = 110
    os_disk_size_gb = 128
    os_disk_type    = "Managed"

    upgrade_settings {
      max_surge = "10%"
    }
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin      = "azure"
    network_plugin_mode = "overlay"
    pod_cidr            = "10.244.0.0/16"
    service_cidr        = "10.0.0.0/16"
    outbound_type       = "loadBalancer"
    load_balancer_sku   = "standard"
  }

  maintenance_window_auto_upgrade {
    day_of_week = "Sunday"
    duration    = 8
    frequency   = "Weekly"
    interval    = 1
    start_date  = "2026-11-04T00:00:00Z"
    start_time  = "00:00"
    utc_offset  = "+00:00"
  }

  maintenance_window_node_os {
    day_of_week = "Sunday"
    duration    = 8
    frequency   = "Weekly"
    interval    = 1
    start_date  = "2026-11-04T00:00:00Z"
    start_time  = "00:00"
    utc_offset  = "+00:00"
  }

}




