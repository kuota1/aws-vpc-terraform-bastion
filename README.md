# aws-vpc-terraform-bastion
Este proyecto implementa una infraestructura base en AWS utilizando Terraform, como punto de partida para construir entornos mas complejos. Ideal para prácticas de redes, seguridad y despliegue de instancias en la nube.

## Arquitectura desplegada

1 VPC personalizada con subredes publicas y privadas.
2 Internet Gateway para acceso público.
3 NAT Gateway para dar salida a internet desde la subred privada.
4 Bastion Host (EC2 pública) para acceso seguro a las instancias privadas.
5 Instancia EC2 privada. accesible solo desde el Bastion.
6 Generacion automatica de clave SSH(.pem) con "tls_private_key".
7 Script de inicializacion ("user_data") para instalar servicios en la EC2 privada.

Tecnologias usadas

Terraform (Infraestructura como codigo)
AWS (VPC, EC2, NAT Gateway, Internet Gateway, etc)
Modulos oficiales de Terraform: "terraform-aws-modules/vpc/aws" y "ec2-instance/aws"

Estructura del proyecto

terraform-manifests/
-c1-version.tf
-c2-generic-variables-tf
-c3-local-values-tf
-c4-01-vpc-variables.tf
-c4-02-vpc-module.tf
-c5-03-securitygroup-bastionsg.tf
-c5-04-securitygroup-rpivatesg.tf
-c6-01-datasource-ami.tf
-c7-03-ec2instance-bastion-tf
-c7-04-ec2instance-private.tf
-c7-05-key-pair.tf
-app1-install-sh

Como usar:
1 git clone
https://github.com/kuota1/aws-vpc-terraform-bastion.git
cd aws-vpc-terraform-bastion
2 inicializa Terraform
-terraform init
3 Revisa el plan de ejecucion
-terraform plan
4 Aplica la infraestructura:
- terraform apply
5 Una vez desplegado conectate al bastion con la clave .pem generada y desde ahi a ala EC" privada.
