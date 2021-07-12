variable "location" {
  type = string
  description = "Región de Azure donde crearemos la infraestructura"
  default = "West Europe"
}

variable "vm_size" {
  type = string
  description = "Tamaño de la máquina virtual"
  default = "Standard_D2s_v3" # 3.5 GB, 1 CPU 
}

variable "machines" {
  type = list(string)
  description = "Máquina virtuales a crear"
  default = ["master", "worker"]
}
