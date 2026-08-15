terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.81.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "rg-backend2"
    storage_account_name = "storagebackend2" # Must be globally unique
    container_name       = "tfstatebackend2"
    key                  = "backend.terraform.tfstate" # Name of your state file
  }
}

provider "azurerm" {
  features {}
}