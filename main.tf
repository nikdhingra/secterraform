terraform {
  backend "azurerm" {
    resource_group_name  = "East US"
    storage_account_name = "mytfacc"
    container_name       = "statefile"
    key                  = "nik-app.tfstate"
    subscription_id      = "9bd2fe7b-8da1-4dad-ac7c-7766fe130a05"
    use_azuread_auth   = true
    sas_token = "sv=2022-11-02&ss=bfqt&srt=co&sp=rwdlacupiytfx&se=2025-02-28T13:44:03Z&st=2025-02-28T05:44:03Z&spr=https&sig=Uqv7EEYdSiqmfmBh47mMnvnA%2FpELAOJXU1urSxWN1xc%3D"
  }
}

#  password = abc123


provider "azurerm" {
  features {}
}

# Create a resource groups
resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "East US"
}

# Create a virtual network
resource "azurerm_virtual_network" "example" {
  name                = "example-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

# Create a subnet in the virtual network.
resource "azurerm_subnet" "example" {
  name                 = "example-subnet"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Create a public IP for the VM
resource "azurerm_public_ip" "example" {
  name                         = "example-public-ip"
  location                     = azurerm_resource_group.example.location
  resource_group_name          = azurerm_resource_group.example.name
  allocation_method            = "Dynamic"
  domain_name_label            = "examplevm-${random_id.random_id.hex}"
}

# Create a network interface for the VM
resource "azurerm_network_interface" "main" {
  name                = "test-nic"
  location            = data.azurerm_resource_group.example.location
  resource_group_name = data.azurerm_resource_group.example.name

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.example.id
  }
}

 
# Generate a random ID for uniqueness (optional, for domain name).
resource "random_id" "random_id" {
  byte_length = 8
}

# Define the SSH key for authentication
resource "azurerm_ssh_key" "example" {
  name                 = "example-ssh-key"
  public_key           = file("~/.ssh/id_rsa.pub")  # Specify your public key file path
  resource_group_name  = azurerm_resource_group.example.name
}

# Create the Ubuntu VM with SSH key authen
