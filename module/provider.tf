terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.79"
    }
  }
  required_version = ">= 0.15"
}

provider "azurerm" {
  features {}
}
