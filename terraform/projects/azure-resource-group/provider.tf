terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.81.0"
    }
  }

    backend "azurerm" {
    resource_group_name  = "rg-rishi"
    storage_account_name = "storeagepipeline"      # Must be globally unique
    container_name       = "tfstate-pipeline"
    key                  = "pipeline.terraform.tfstate" # Name of your state file
  }
}

provider "azurerm" {
  features {}
}