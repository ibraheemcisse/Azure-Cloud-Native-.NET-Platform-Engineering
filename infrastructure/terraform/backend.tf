terraform {
  backend "azurerm" {
    resource_group_name  = "rg-terraform-state"
    storage_account_name = "ibraheemtfstate"
    container_name       = "tfstate"
    key                  = "pizzastore.terraform.tfstate"

    use_azuread_auth = true
  }
}
