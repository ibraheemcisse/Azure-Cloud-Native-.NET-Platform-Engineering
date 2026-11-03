resource "azurerm_resource_group" "pizzastore" {
  name     = "rg-pizzastore-dev"
  location = "westeurope"
}

resource "azurerm_container_registry" "pizzastore" {
  name                          = "ibraheempizzastoreacr"
  resource_group_name           = azurerm_resource_group.pizzastore.name
  location                      = "northeurope"
  sku                           = "Basic"
  admin_enabled                 = false
  public_network_access_enabled = true
}
