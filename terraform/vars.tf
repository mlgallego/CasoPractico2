#											                                                       [modify]


# Variables 

# Indica el listado de los nombres de las maquinas a crear. El orden de la 
# lista influye en las siguientes variables: vm_size, nfs_machine, machine_ip
variable "machines" {
  type = list(string)
  description = "Máquina virtuales a crear"
  default = ["master","worker01","worker02"] 
}

# La lista contiene las máquinas asociadas a las máquinas de la variable machines. 
# Éstas se asocian según el orden establecido
variable "vm_size" {
  type = list(string)
  description = "Tamaño de la máquina virtual"
  default =  ["Standard_D2s_v3","Standard_D1_v2","Standard_D1_v2"] 
}

# Se seleccionará la posición que ocupa la maquina con el rol de nfs del listado machines. 
# La primera posición parte del valor 0
variable "nfs_machine"{
  type = number
  description = "posición de la maquina en la lista de machines  con el rol de NFS"
  default = 0
}

# La lista contiene las IP asociadas a las maquinas de la variable "machines". 
# Estas IPs deben de estar dentro del rango de la variable ip_subnet
variable "machine_ip"{
  type = list(string)
  description = "IP asignada a maquina (machines list)"
  default = ["10.0.1.10","10.0.1.11","10.0.1.12"]
}

# Contiene el rango de la red privada que albergara la red de Azure
variable "ip_network"{
  type = string
  description = "Network IP range"
  default = "10.0.0.0/16"
}

# Se define el subrango de IPs que contendrán las maquinas y que serán asociadas en la variable "machine_ip"
variable "ip_subnet"{
  type = string
  description = "Subnet IP range"
  default = "10.0.1.0/24"
}
