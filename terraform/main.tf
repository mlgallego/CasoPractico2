#											      [modify]


# El bloque required_providers establece el origen (source) y la version  a emplear [1]
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.1"
    }
  }
}


# Administración de un grupo de recursos [2]
resource "azurerm_resource_group" "rg" {
    name     = "kubernetes_rg"
    location = var.location

    tags = {
        environment = "CP2"
    }

}


# Creación de cuenta de almacenamiento de Azure [3]
resource "azurerm_storage_account" "storageAccount" {
    name                     = var.storage_account    # Nombre de la cuenta de almacenamiento.
    							                                    #Debe ser único en todo Azure,
                                                      #no solo dentro del grupo de recursos. 
    resource_group_name      = azurerm_resource_group.rg.name
    location                 = azurerm_resource_group.rg.location
    account_tier             = "Standard"             # Nivel de la cuenta de almacenamiento
    account_replication_type = "LRS"                  # Tipo de replicación

    tags = {
        environment = "CP2"
    }

}


# Enlace a los recursos:
# [1]https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs
# [2]https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group
# [3]https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account
