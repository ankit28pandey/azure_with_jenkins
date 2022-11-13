terraform {
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = "3.31.0"
    }
  }
}

provider "azurerm" {
    tenant_id  = "23035d1f-133c-44b5-b2ad-b3aef17baaa1"
    subscription_id =  "19fd7810-9b54-4adc-919f-68afdb039efa"
    client_id = "8d24b432-6f8d-41a5-9e50-11f445555b19"
    client_secret = "_xr8Q~D-V68ZtazvkqjalOg_sP0kH32chML6rcfu"
}

resource "azurerm_resource_group" "example" {
    name = "terraform-resource"
    location = "West India"
}

resource "azurerm_virtual_network" "example" {
    name = "terraform-vn"
    address_space = "10.0.0.0/32"
    location = azurerm_resource_group.example.location
    resource_group_name = azurerm_resource_group.example.name
}

resource "azure_subnet" "example" {
    name = "terraform-subnet"
    address_space = "10.0.0.0/24"
    resource_group_name = azurerm_resource_group.example.name
    virtual_network_name = azurerm_virtual_network.example.name
}

resource "azurerm_network_interface" "example" {
    name = "terraform-ip"
    location = azurerm_resource_group.example.location
    resource_group_name = azure_resource_group.example.name

    ip_configuraton {
        name = "terraform-subnet"
        subnet_id = azure_subnet.example.id
    }
}

resource "azurerm_linux_virtual_machine" "example" {
    name = "terraform-vm"
    resource_group_name = azurerm_resource_group.example.name
    location = azure_resource_group.example.location
    size = "Standard_F2"
    admin_username = "adminuser"

    network_interface_ids = [
        azurerm_network_interface.example.id,
        ]

    admin_ssh_key {
        username = "adminuser"
        public_key = file("~/.ssh/id_rsa.pub")
    }

    os_disk {
        caching = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }

    source_image_reference {
        publisher = "Canonical"
        offer = "UbuntuServer"
        sku = "16.04-LTS"
        version = "latest"
    }

}
