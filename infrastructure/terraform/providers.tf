terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.72"
    }
  }
}

provider "azurerm" {
  features {}

  subscription_id = "81eda261-6bfa-4968-8fb0-2bcfb2e8469c"
}
