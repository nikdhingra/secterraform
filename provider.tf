terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.2.0"
    }
  }
}

provider "azurerm" {
  resource_provider_registrations = "none"
  subscription_id = "2213e8b1-dbc7-4d54-8aff-b5e315df5e5b"
  features {
    
  }
}


resource "azurerm_resource_group" "sg-account" {
  name     = "example-resources"
  location = "West Europe"
}

resource "azurerm_storage_account" "sg-account" {
  name                     = "mysecstgacc"
  resource_group_name      = azurerm_resource_group.sg-account.name
  location                 = azurerm_resource_group.sg-account.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "staging"
  }
}

resource "azurerm_storage_container" "sg-account" {
  name                  = "example-container"
  storage_account_id    = azurerm_storage_account.sg-account.id
  container_access_type = "private" 
}