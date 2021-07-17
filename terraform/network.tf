# Creación de red
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network

resource "azurerm_virtual_network" "azureNetwork" {
    name                = "kubernetesNetwork"
    address_space       = [var.ip_network]
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name

    tags = {
        environment = "CP2"
    }
}

# Creación de subnet
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet

resource "azurerm_subnet" "azureSubnet" {
    name                   = "terraformSubnet"
    resource_group_name    = azurerm_resource_group.rg.name
    virtual_network_name   = azurerm_virtual_network.azureNetwork.name
    address_prefixes       = [var.ip_subnet]

}

# Create NIC
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface

resource "azurerm_network_interface" "nickGroup" {
  count               = length(var.machines)
  name                = "vmnic-${var.machines[count.index]}"  
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

    ip_configuration {
    name                           = "ipconfiguration-${var.machines[count.index]}"
    subnet_id                      = azurerm_subnet.azureSubnet.id 
    private_ip_address_allocation  = "Static"
    private_ip_address             = var.machine_ip[count.index]
    public_ip_address_id           = "${element(azurerm_public_ip.publicGroup.*.id, count.index )}"

  }

    tags = {
        environment = "CP2"
    }

}

# IP pública
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip

resource "azurerm_public_ip" "publicGroup" {

    count               = length(var.machines)
    name                = "${var.machines[count.index]}ip"
    domain_name_label   = "${var.machines[count.index]}mlgm"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    allocation_method   = "Dynamic"
    sku                 = "Basic"

    tags = {
        environment = "CP2"
    }

}
