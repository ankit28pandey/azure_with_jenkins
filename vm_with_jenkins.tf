terraform {
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = "=3.0.0"
    }
  }
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
