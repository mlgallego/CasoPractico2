#								                 [modify]


# Security group [1]
resource "azurerm_network_security_group" "securityGroup" {
    name                = "sshtraffic"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name

    security_rule {
        name                       = "SSH"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    tags = {
        environment = "CP2"
    }
}

# Vinculamos el security group al interface de red [2]
resource "azurerm_network_interface_security_group_association" "secGroupAssociation" {
    count                     = length(var.machines)
    network_interface_id      = "${element(azurerm_network_interface.nickGroup.*.id, count.index)}"
    network_security_group_id = azurerm_network_security_group.securityGroup.id

}

# Enlace a los recursos:
# [1]https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group
# [2]https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface_security_group_association
