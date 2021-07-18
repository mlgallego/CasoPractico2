# El objetivo de este proyecto es permitir a cualquier usuario familiarizarse con el despliegue de 
una aplicación de forma automatizada en el entorno cloud de Azure empleando para ello: 
- **Terraform**, como herramienta de código para el despliegue de infraestructura y
- ** Ansible** como software de gestión de configuración y despliegue de aplicaciones y 

# Terraform
## Arquitectura a desplegar en Terraform: 
![Arquitectura a desplegar con Terraform](imagen/CONTRIBUTING.md)

![alt text](images/Terraform-Architecture.png)

##  Comandos para el despliegue de la arquitectura de Terraform en Azure
1. Clonamos este repositorio y accedemos a la carperta terraform
``` XXX@Azure: git clone https://github.com/mlgallego/CasoPractico2 ```
    XXX@Azure: cd CasoPractico2/terraform
```
2. Genere un archivo credentials.tf y guardelo en la carpeta terraform (permite autenticar Terraform en Azure) 

``` XXX@Azure: mv credentials.tf CasoPractico2/terraform/credentials.tf ```

3. Inicializamos un directorio para que Terraform se ejecute en él
``` XXX@Azure: terraform init ```

4. Generamos un plan de Terraform 
``` XXX@Azure: terraform plan ```


5. Desplegamos la infraestructura de Terraform y la visualizamos
``` XXX@Azure: terraform apply 
    XXX@Azure: terraform show ```

6. Si queremos destruir la infraestructura 
``` XXX@Azure: terraform destroy ```
