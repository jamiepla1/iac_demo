# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used.
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "=2.71.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}

  # More information on the authentication methods supported by
  # the AzureRM Provider can be found here:
  # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs

  # subscription_id = "..."
  # client_id       = "..."
  # client_secret   = "..."
  # tenant_id       = "..."
}

# Create a resource group
resource "azurerm_resource_group" "myrg" {
  name     = "IAC Demo"
  location = "UK South"
}

# Create a virtual network in the IAC Demo resource group
resource "azurerm_virtual_network" "myvnet" {
  name                = "IAC Demo"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  address_space       = ["10.0.0.0/16"]
}

#create a subnet within the vnet
resource "azurerm_subnet" "mysubnet" {
    name                 = "iac_demo_subnet"
    resource_group_name  = azurerm_resource_group.myrg.name
    virtual_network_name = azurerm_virtual_network.myvnet.name
    address_prefix       = ["10.0.1.0/24"]
}