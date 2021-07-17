variable "location" {
  type = string
  description = "Región de Azure donde crearemos la infraestructura"
  default = "West Europe"
}

variable "vm_size" {
  type = list(string)
  description = "Tamaño de la máquina virtual"
  default =  ["Standard_D2s_v3","Standard_D2s_v3"] 
}

variable "machines" {
  type = list(string)
  description = "Máquina virtuales a crear"
  default = ["master","worker01"] 
}
variable "nfs_machine"{
  type = number
  description = "posición de la maquina en la lista de machines  con el rol de NFS"
  default = 0
}
variable "machine_ip"{
  type = list(string)
  description = "IP asignada a maquina (machines list)"
  default = ["10.0.1.10","10.0.1.11"]
}
variable "ip_network"{
  type = string
  description = "Network IP range"
  default = "10.0.0.0/16"
}
variable "ip_subnet"{
  type = string
  description = "Subnet IP range"
  default = "10.0.1.0/24"
}
