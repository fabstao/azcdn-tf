# Main Terraform

provider "azurerm" {
  features {}
}

terraform {

  required_providers {

    azurerm = {
      source = "hashicorp/azurerm"
    }
  }
}

resource "azurerm_resource_group" "suracdn" {
  name     = "suracdn"
  location = "East US"
}
