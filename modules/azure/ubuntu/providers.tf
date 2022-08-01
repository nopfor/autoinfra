
terraform {
  required_providers {
    azurerm  = {
      source  = "hashicorp/azurerm"
      version = ">= 3.5.0"
    }
    null = {
      source = "hashicorp/null"
      version = ">= 3.1.1"
    }
  }
}
