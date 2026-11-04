resource "azurerm_role_assignment" "aks_acr_pull" {
  scope                = azurerm_container_registry.pizzastore.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.pizzastore.kubelet_identity[0].object_id
}
