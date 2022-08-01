
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.8.0"
    }
    azurerm  = {
      source  = "hashicorp/azurerm"
      version = ">= 3.5.0"
    }
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = ">= 2.19.0"
    }
  }
}
