#											     [modify]


# Creación de máquinas virtuales [1]
resource "azurerm_linux_virtual_machine" "vms" {
    count               = length(var.machines)
    name                = "${var.machines[count.index]}-azure-vm"
    resource_group_name = azurerm_resource_group.rg.name
    location            = azurerm_resource_group.rg.location
    size                = var.vm_size[count.index]
    admin_username      = "adminUsername"
    network_interface_ids = ["${element(azurerm_network_interface.nickGroup.*.id, count.index)}"]
    disable_password_authentication = true

    admin_ssh_key {
        username   = "adminUsername"
        public_key = file("~/.ssh/id_rsa.pub")
    }

    os_disk {
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }

    plan {
        name      = "centos-8-stream-free"
        product   = "centos-8-stream-free"
        publisher = "cognosys"
    }

    source_image_reference {
        publisher = "cognosys"
        offer     = "centos-8-stream-free"
        sku       = "centos-8-stream-free"
        version   = "1.2019.0810"
    }

    boot_diagnostics {
        storage_account_uri = azurerm_storage_account.storageAccount.primary_blob_endpoint
    }

    tags = {
        environment = "CP2"
    }

}

# Creación adicional de disco duro para el NFS [2]
resource "azurerm_managed_disk" "nfs_disk" {
  name                 = "nfs_disk01"
  location             = azurerm_resource_group.rg.location
  resource_group_name  = azurerm_resource_group.rg.name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = 10
}

# Adjuntar el disco adicional a la máquina que ha sido seleccionada en el archivo vars.tf  
# haciendo referencia a su posición en la lista de la variable machines [3]
resource "azurerm_virtual_machine_data_disk_attachment" "managed_disk_attach" {
  managed_disk_id    = azurerm_managed_disk.nfs_disk.id
  virtual_machine_id = azurerm_linux_virtual_machine.vms.*.id[var.nfs_machine]
  lun                = 10
  caching            = "ReadWrite"
}

# Enlace a los recursos:
# [1]https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machinep
# [2]https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/managed_disk
# [3]https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_data_disk_attachment
